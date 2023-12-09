//
//  MovieListPresenter.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import Foundation

protocol MovieListPresenterLogic {
    func getMovieList()
}

class MovieListPresenter: MovieListPresenterLogic {
    
    var listType: MovieListType?
    var movieList: MovieList? {
        didSet{
            presentDisplayMovies()
        }
    }
    weak var viewController: MovieListDisplayLogic?
    
    init(viewController: MovieListDisplayLogic? = nil) {
        self.viewController = viewController
    }
    
    func getMovieList() {
        APIManager.shared.getMovies(listType: listType ?? .nowPlaying, parameters: nil) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movieList = movies
            case .failure( _):
                break
            }
        }
    }
    
    private func presentDisplayMovies(){
        
        guard let movies = movieList?.results else {
            return
        }
        
        var displayMovies = [DisplayMovie]()
        for movie in movies {
            let displayMovie = DisplayMovie(id: movie.id,
                                            title: movie.title,
                                            overview: movie.overview,
                                            posterPath: movie.posterPath,
                                            backdropPath: movie.backdropPath,
                                            voteAverage: movie.voteAverage)
            displayMovies.append(displayMovie)
        }
        viewController?.displayMovies(displayMovies)
    }
}
