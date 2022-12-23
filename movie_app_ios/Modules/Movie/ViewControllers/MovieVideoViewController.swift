//
//  MovieVideoViewController.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import UIKit

class MovieVideoViewController: UIViewController {
    var viewModel: MovieVideoViewModelProtocol?
    var movieData: Movie?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regisTableViewCell()
        viewModel?.getMovieVideo(id: movieData?.id ?? 0)
        viewModel?.didFinishGetVideo = onFinishGetVideo
    }
    
    func onFinishGetVideo(_ error: String?) {
        tableView.reloadData()
    }
    
    func regisTableViewCell() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MovieVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
}

extension MovieVideoViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.videoList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel?.videoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MovieVideoTableViewCell
        cell.video = item
        cell.setupUI()
        
        return cell
    }
}
