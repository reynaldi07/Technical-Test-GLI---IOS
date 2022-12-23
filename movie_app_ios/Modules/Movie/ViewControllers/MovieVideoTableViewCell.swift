//
//  MovieVideoTableViewCell.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import UIKit
import WebKit

class MovieVideoTableViewCell: UITableViewCell, WKNavigationDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    var video: Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupWebView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWebView() {
        self.webView.navigationDelegate = self
        self.webView.allowsBackForwardNavigationGestures = true
    }
    
    func setupUI() {
        nameLabel.text = video?.name
        typeLabel.text = video?.type
        if let url = URL(string: "\(Constants().getBaseUrlYoutubeEmbed())\(self.video?.key ?? "")") {
            self.webView.load(URLRequest(url: url))
        }
    }
    
}
