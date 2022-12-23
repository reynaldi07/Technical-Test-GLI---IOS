//
//  UpcomingUIViewController.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 21/12/22.
//

import UIKit

class UpcomingUIViewController: UIViewController {
    var viewModel: HomeViewModelProtocol?
    var movieTapped: ((_ data: Movie) -> Void)?
    
    @IBOutlet weak var movieCollection: UICollectionView!
    
    convenience init(viewModel: HomeViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollection.delegate = self
        movieCollection.dataSource = self
        setupUI()
        registerMovieGrid()
        viewModel?.getUpcomingMovies()
        viewModel?.didFinishGetUpcomingMovies = onFinishedGetMovies
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
        let nib = UINib(nibName: MovieCollectionViewCell.nibName, bundle: nil)
        movieCollection?.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    }
    
    func onFinishedGetMovies(_ error: String?) {
        movieCollection.reloadData()
    }
}

extension UpcomingUIViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return viewModel?.upcomingMovies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.viewModel?.upcomingMovies?.results?[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath as IndexPath) as! MovieCollectionViewCell
        
        cell.setupUI(movie: movie!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel?.upcomingMovies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.viewModel?.upcomingList[indexPath.row]
        self.movieTapped?(movie!)
    }
}

extension UpcomingUIViewController : UICollectionViewDelegateFlowLayout {
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
