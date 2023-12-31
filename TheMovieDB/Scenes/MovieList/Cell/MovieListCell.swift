//
//  MovieListCell.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import UIKit

class MovieListCell: UITableViewCell {
    
    static let cellIdentificator = "MovieListCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var ratingView: RatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        setupStyle()
    }
    
    private func setupCell(){
        titleLabel.text = .empty
        descriptionLabel.text = .empty
        posterImage.image = nil
    }
    
    private func setupStyle(){
        infoContainerView.layer.cornerRadius = 5
        infoContainerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        ratingView.layer.cornerRadius = ratingView.bounds.width / 2
    }
    
    func configureCell(_ movie: DisplayMovie?) {
        setupCell()
        titleLabel.text = movie?.title
        descriptionLabel.text = movie?.overview
        posterImage.setImageFromURL(movie?.posterPath)
        ratingView.setRating(movie?.voteAverage ?? 0)
    }
  
}

