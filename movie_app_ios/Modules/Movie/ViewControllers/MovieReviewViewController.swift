//
//  MovieReviewViewController.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import UIKit

class MovieReviewViewController: UIViewController {
    var viewModel: MovieReviewViewModelProtocol?
    var movieData: Movie?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regisTableViewCell()
        viewModel?.getMovieReview(id: movieData?.id ?? 0)
        viewModel?.didFinishGetReview = onFinishGetReview
    }
    
    func onFinishGetReview(_ error: String?) {
        tableView.reloadData()
    }
    
    func regisTableViewCell() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
}

extension MovieReviewViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.reviewList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel?.reviewList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MovieReviewTableViewCell
        cell.setupUI(data: item!)
        
        return cell
    }
}
