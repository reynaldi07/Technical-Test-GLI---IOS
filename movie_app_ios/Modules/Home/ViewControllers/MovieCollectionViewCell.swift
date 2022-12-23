//
//  MovieCollectionViewCell.swift
//  movie_app_ios
//
//  Created by Reynaldi Pamungkas on 13/12/22.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class var reuseIdentifier: String {
        return  "CollectionViewCellReuseIdentifier"
    }
    
    class var nibName: String {
        return "MovieCollectionViewCell"
    }
    
    func setupUI(movie: Movie) {
        if let imageUrl = URL(string: "\(Constants().getBaseUrlImage())\(movie.posterPath ?? "")") {
            movieImage.sd_setImage(with: imageUrl)
        }
    }
}
