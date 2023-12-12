//
//  RatingView.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 12/12/23.
//

import UIKit

class RatingView: UIView {

    static let viewNib = "RatingView"

    @IBOutlet weak var ratingLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView(){
        let view = Bundle.main.loadNibNamed(RatingView.viewNib, owner: self, options: nil)?.first as? UIView
        
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view?.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view ?? UIView())
    }
    
    func setRating(_ rating: Double) {

        ratingLabel.text = String(format: "%.1f", rating)
        switch rating {
        case 7...10:
            backgroundColor = .systemGreen
        case 4...7:
            backgroundColor = .systemYellow
        case 0:
            backgroundColor = .darkGray
        default:
            backgroundColor = .systemRed
        }
    }
}
