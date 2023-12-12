//
//  SearchMoviePresenter.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 12/12/23.
//

import Foundation

protocol SearchMoviePresenterLogic {
    func searchText(text: String?)
    func loadPage()
}

class SearchMoviePresenter: SearchMoviePresenterLogic {

    weak var viewController: SearchMovieDisplayLogic?
    var moviesResult: MovieList?
    var currentPage = 1
    var queryText: String = .empty
    
    init(viewController: SearchMovieDisplayLogic? = nil) {
        self.viewController = viewController
    }
    
    func searchText(text: String?) {
        guard let text = text, text != queryText else {
            return
        }
        
        queryText = text
        currentPage = 1
        searchText(query: queryText) { [weak self] movies in
            self?.moviesResult = movies
            self?.presentDisplayMovies()
        }
    }
    
    private func searchText(query: String, completion: @escaping ((MovieList) -> Void)) {
        APIManager.shared.searchMovie(with: query, page: currentPage) { result in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure( _):
                break
            }
        }
    }
    
    private func presentDisplayMovies(append: Bool = false){
        guard let movies = moviesResult?.results else {
            return
        }
        
        var displayMovies = [DisplayMovie]()
        for movie in movies {
            let displayMovie = DisplayMovie(id: movie.id,
                                            title: movie.title,
                                            overview: movie.overview,
                                            posterPath: movie.posterURL,
                                            voteAverage: movie.voteAverage)
            displayMovies.append(displayMovie)
        }
        viewController?.displayMovies(displayMovies, append: append)
    }
    
    func loadPage() {
        currentPage += 1
        searchText(query: queryText) { [weak self] movies in
            self?.moviesResult = movies
            self?.presentDisplayMovies(append: true)
        }
    }
}
