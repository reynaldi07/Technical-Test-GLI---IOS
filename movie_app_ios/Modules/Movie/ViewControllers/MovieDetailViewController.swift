//
//  MovieDetailViewController.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var viewModel: MovieDetailViewModelProtocol?
    var movieData: Movie?
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var reviewsView: UIView!
    @IBOutlet weak var videosView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getDetailMovie(id: movieData?.id ?? 0)
        viewModel?.didFinishGetDetailMovie = onFinishGetDetailMovie
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constants.Segue.goToReviewSegue) {
            let movieReviewView = segue.destination as! MovieReviewViewController
            let movie = sender as! Movie
            let vm = MovieReviewViewModel.init(service: MovieService())
            movieReviewView.movieData = movie
            movieReviewView.viewModel = vm
        }
        if (segue.identifier == Constants.Segue.goToVideoSegue) {
            let movieVideoView = segue.destination as! MovieVideoViewController
            let movie = sender as! Movie
            let vm = MovieVideoViewModel.init(service: MovieService())
            movieVideoView.movieData = movie
            movieVideoView.viewModel = vm
        }
    }
    
    func setupUI() {
        rateLabel.text = "\(movieData?.voteCount ?? 0)"
        titleLabel.text = movieData?.title
        overviewLabel.text = movieData?.overview
        genreLabel.text = movieData?.genres?[0].name ?? ""
        runtimeLabel.text = "\(movieData?.runtime ?? 0) Minutes"
        releaseDateLabel.text = movieData?.releaseDate
        if let imageBackdrop = URL(string: "\(Constants().getBaseUrlImage())\(movieData?.backdropPath ?? "")") {
            backdropImage.sd_setImage(with: imageBackdrop)
        }
        if let imagePoster = URL(string: "\(Constants().getBaseUrlImage())\(movieData?.posterPath ?? "")") {
            posterImage.sd_setImage(with: imagePoster)
        }
        tapGestureReview()
        tapGestureVideo()
    }
    
    func onFinishGetDetailMovie(_ error: String?) {
        if error != nil {
            emptyView.layer.isHidden = false
            contentView.layer.isHidden = true
            emptyLabel.text = error
            emptyImage.image = UIImage(systemName: "wrongwaysign")
            return
        }
        self.movieData = viewModel?.dataMovie
        setupUI()
    }
    
    func tapGestureReview() {
        let tapGestureReview = UITapGestureRecognizer(target: self, action: #selector(showReview(tapGestureReview:)))
        reviewsView.addGestureRecognizer(tapGestureReview)
        reviewsView.isUserInteractionEnabled = true
    }
    
    func tapGestureVideo() {
        let tapGestureVideo = UITapGestureRecognizer(target: self, action: #selector(showVideo(tapGestureVideo:)))
        videosView.addGestureRecognizer(tapGestureVideo)
        videosView.isUserInteractionEnabled = true
    }
    
    @objc func showReview(tapGestureReview: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: Constants.Segue.goToReviewSegue, sender: self.movieData)
    }
    
    @objc func showVideo(tapGestureVideo: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: Constants.Segue.goToVideoSegue, sender: self.movieData)
    }
}
