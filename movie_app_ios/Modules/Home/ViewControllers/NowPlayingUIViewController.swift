//
//  NowPlayingUIViewController.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 13/12/22.
//

import UIKit
import Toast_Swift

class NowPlayingUIViewController: UIViewController {
    var viewModel: HomeViewModelProtocol?
    var movieTapped: ((_ data: Movie) -> Void)?
    var refreshController: UIRefreshControl!
    private var isLoading: Bool  = false {
        didSet {
            isLoading ? loadingView.showLoading() : loadingView.hideLoading()
        }
    }
    private lazy var loadingView: LoadingView = {
        let view = LoadingView(height: 80)
        view.backgroundColor = .clear
        view.hideLoading()
        return view
    }()
    
    @IBOutlet weak var movieCollection: UICollectionView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var emptyImage: UIImageView!
    
    convenience init(viewModel: HomeViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isLoading = true
        movieCollection.delegate = self
        movieCollection.dataSource = self
        setupUI()
        registerMovieGrid()
        viewModel?.getNowPlayingMovies()
        viewModel?.didFinishGetNowPlayingMovies = onFinishedGetMovies
    }
    
    func setupUI() {
        movieCollection.contentInset = UIEdgeInsets(
            top: 13,
            left: 13,
            bottom: 13,
            right: 13
        )
    }
    
    func registerMovieGrid() {
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)
        let nib = UINib(nibName: MovieCollectionViewCell.nibName, bundle: nil)
        movieCollection?.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        movieCollection.refreshControl = refreshController
    }
    
    func onFinishedGetMovies(_ error: String?) {
        DispatchQueue.main.async {
            self.refreshController.endRefreshing()
            self.isLoading = false
            if let error = error {
                self.view.makeToast(error, duration: 2.0, position: .bottom)
            }

        }
        if error != nil {
            emptyView.layer.isHidden = false
            movieCollection.layer.isHidden = true
            emptyLabel.text = error
            emptyImage.image = UIImage(systemName: "wrongwaysign")
            return
        }
        if viewModel?.nowPlayingList.isEmpty == true {
            emptyView.layer.isHidden = false
            movieCollection.layer.isHidden = true
            emptyLabel.text = "we are sorry, we can not find the movie"
        } else {
            emptyView.layer.isHidden = true
            movieCollection.layer.isHidden = false
        }
        movieCollection.reloadData()
    }
    
    @objc func onPullToRefresh(_ sender: Any) {
        self.isLoading = true
        viewModel?.currentPageNowPlaying = 1
        viewModel?.nowPlayingList = []
        viewModel?.getNowPlayingMovies()
    }
    
    @IBAction func tryAgainPressed(_ sender: UIButton) {
        self.isLoading = true
        viewModel?.currentPageNowPlaying = 1
        viewModel?.nowPlayingList = []
        viewModel?.getNowPlayingMovies()
    }
}

extension NowPlayingUIViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return viewModel?.nowPlayingList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.viewModel?.nowPlayingList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        
        cell.setupUI(movie: movie!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel?.nowPlayingList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.viewModel?.nowPlayingList[indexPath.row]
        self.movieTapped?(movie!)
    }
}

extension NowPlayingUIViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let numberofItem: CGFloat = 4
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let collectionViewWidth = self.movieCollection.bounds.width
        
        let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing
        
        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
        
        let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
        
        return CGSize(width: width, height: width + 46)
    }
}

extension NowPlayingUIViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if maximumOffset - currentOffset <= 10.0 && viewModel?.currentPageNowPlaying ?? 0 <= viewModel?.nowPlayingMovies?.totalPages ?? 0 {
            if viewModel?.nowPlayingMovies?.results?.count ?? 0 <= 0 {
                viewModel?.getNowPlayingMovies()
            } else {
                viewModel?.currentPageNowPlaying += 1
                viewModel?.getNowPlayingMovies()
            }
        }
    }
}
