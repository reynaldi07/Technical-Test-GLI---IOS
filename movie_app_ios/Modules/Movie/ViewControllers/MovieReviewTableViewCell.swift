//
//  MovieReviewTableViewCell.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 22/12/22.
//

import UIKit

class MovieReviewTableViewCell: UITableViewCell {
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI(data: Review) {
        rateLabel.text = "\(data.authorDetails?.rating ?? 0.0)"
        nameLabel.text = data.author
        commentLabel.text = data.content
        
        if data.authorDetails?.avatarPath != nil {
            authorImage.sd_setImage(with:URL(string: "\(Constants().getBaseUrlImage())\(data.authorDetails?.avatarPath ?? "")"))
        } else {
            authorImage.image = UIImage(systemName: "person.crop.circle")
        }
    }
}
