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
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    @IBOutlet weak var emptyImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        regisTableViewCell()
        viewModel?.getMovieVideo(id: movieData?.id ?? 0)
        viewModel?.didFinishGetVideo = onFinishGetVideo
    }
    
    func onFinishGetVideo(_ error: String?) {
        if error != nil {
            emptyView.layer.isHidden = false
            tableView.layer.isHidden = true
            emptyLabel.text = error
            emptyImage.image = UIImage(systemName: "wrongwaysign")
            return
        }
        if viewModel?.videoList.isEmpty == true {
            emptyView.layer.isHidden = false
            tableView.layer.isHidden = true
            emptyLabel.text = "we are sorry, we can not find the video"
        }
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
