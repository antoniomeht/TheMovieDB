//
//  MovieDetailPresenter.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 10/12/23.
//

import Foundation

protocol MovieDetailPresenterLogic {
    func getMovieDetail(_ movieId: Int)
}

class MovieDetailPresenter: MovieDetailPresenterLogic {
    
    var movieDetails: Movie?
    weak var viewController: MovieDetailDisplayLogic?

    init(viewController: MovieDetailDisplayLogic? = nil) {
        self.viewController = viewController
    }
    
    func getMovieDetail(_ movieId: Int) {
        getMovieDetail(movieId) { [weak self] details in
            self?.movieDetails = details
            self?.presentDisplatDetail()
        }
    }
    
    private func getMovieDetail(_ movieId: Int, completion: @escaping ((Movie) -> Void)) {
        APIManager.shared.getMovieDetail(movieId: movieId) { result in
            switch result {
            case .success(let details):
                completion(details)
            case .failure( _):
                break
            }
        }
    }
    
    private func presentDisplatDetail() {
        guard let details = movieDetails else {
            return
        }
        
        let displayMovieDetail = DisplayMovieDetail(id: details.id,
                                                    title: details.title,
                                                    overview: details.overview,
                                                    backdropPath: details.backdropURL,
                                                    genres: details.genres,
                                                    releaseDate: details.releaseDate,
                                                    popularity: details.popularity,
                                                    adult: details.adult,
                                                    movieDuration: details.movieDuration,
                                                    voteCount: details.voteCount,
                                                    voteAverage: details.voteAverage,
                                                    production: details.production)
        
        viewController?.displayMovieDetail(displayMovieDetail)
    }
    
}
