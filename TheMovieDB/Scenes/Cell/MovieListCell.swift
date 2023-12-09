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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell(){
        titleLabel.text = .empty
        descriptionLabel.text = .empty
        posterImage.image = nil
    }
    
    func configureCell(_ movie: DisplayMovie?) {
        titleLabel.text = movie?.title
        descriptionLabel.text = movie?.overview
    }
    
}
