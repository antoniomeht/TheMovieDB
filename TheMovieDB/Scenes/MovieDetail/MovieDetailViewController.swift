//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 10/12/23.
//

import UIKit

protocol MovieDetailDisplayLogic: AnyObject {
    func displayMovieDetail(_ detail: DisplayMovieDetail)
}

class MovieDetailViewController: BaseViewController, MovieDetailDisplayLogic {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var adultRatedIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var movieId: Int
    var presenter: MovieDetailPresenterLogic?
    
    required init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.getMovieDetail(movieId)
    }

    private func setupView() {
        title = StringConstants.MovieDetail.title
        presenter = MovieDetailPresenter(viewController: self)
    }
    
    func displayMovieDetail(_ detail: DisplayMovieDetail) {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = detail.title
            self?.descriptionLabel.text = detail.overview
            self?.releaseDateLabel.text = detail.releaseDate
            self?.durationLabel.text = detail.movieDuration
            self?.movieImageView.setImageFromURL(detail.backdropPath)
            self?.adultRatedIcon.isHidden = !(detail.adult ?? false)
        }
    }
}
