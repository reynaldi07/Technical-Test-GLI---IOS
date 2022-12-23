//
//  HomeViewController.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 13/12/22.
//

import UIKit

class HomeViewController: UISimpleSlidingTabController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        // navigation
        navigationItem.title = "Movie App"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barStyle = .black
        
        setupSlidingTab()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constants.Segue.goToMovieDetailSegue) {
            let movieDetailView = segue.destination as! MovieDetailViewController
            let movie = sender as? Movie
            let vm = MovieDetailViewModel.init(service: MovieService())
            movieDetailView.movieData = movie
            movieDetailView.viewModel = vm
        }
    }
    
    func setupSlidingTab() {
        let vm = HomeViewModel.init(service: MovieService())
        let vcNowPlaying = NowPlayingUIViewController.init(viewModel: vm)
        vcNowPlaying.movieTapped = { data in
            self.onMovieTapped(data)
        }
        let vcUpcoming = UpcomingUIViewController.init(viewModel: vm)
        vcUpcoming.movieTapped = { data in
            self.onMovieTapped(data)
        }
        addItem(item: vcNowPlaying, title: "Now playing")
        addItem(item: vcUpcoming, title: "Upcoming")
        setHeaderActiveColor(color: .white)
        setHeaderInActiveColor(color: .Custom.grey)
        setHeaderBackgroundColor(color: .Custom.primary)
        setCurrentPosition(position: 0)
        setStyle(style: .fixed)
        build()
    }
    
    func onMovieTapped(_ data: Movie) {
        self.tabBarController?.tabBar.isHidden = true
        self.performSegue(withIdentifier: Constants.Segue.goToMovieDetailSegue, sender: data)
    }
}
