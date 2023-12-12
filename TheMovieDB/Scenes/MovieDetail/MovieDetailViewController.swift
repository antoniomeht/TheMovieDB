//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 10/12/23.
//

import UIKit

protocol MovieDetailDisplayLogic: AnyObject {
    
}

class MovieDetailViewController: UIViewController, MovieDetailDisplayLogic {

    var movieId: Int
    
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
    }

    private func setupView() {
        
    }
}
