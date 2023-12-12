//
//  MovieListPresenter.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import Foundation

protocol MovieListPresenterLogic {
    func getNewMovieList()
    func setMovieListType(_ type: MovieListType)
    func loadPage()
}

class MovieListPresenter: MovieListPresenterLogic {
    
    var listType: MovieListType? {
        didSet {
            reloadMovieList()
        }
    }
    var movieList: MovieList?
    var currentPage = 1
    weak var viewController: MovieListDisplayLogic?
    
    init(viewController: MovieListDisplayLogic? = nil) {
        self.viewController = viewController
    }
    
    func getNewMovieList() {
        currentPage = 1
        getMovieList { [weak self] movieList in
            self?.movieList = movieList
            self?.presentDisplayMovies()
        }
    }
    
    private func getMovieList(completion: @escaping ((MovieList) -> Void)){
        APIManager.shared.getMovies(listType: listType ?? .nowPlaying, page: currentPage) {result in
            switch result {
            case .success(let movies):
                completion(movies)
            case .failure( _):
                break
            }
        }
    }
    
    private func presentDisplayMovies(append: Bool = false){
        guard let movies = movieList?.results else {
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
    
    private func reloadMovieList(){
        movieList?.results = [Movie]()
        getNewMovieList()
    }
    
    func setMovieListType(_ type: MovieListType) {
        listType = type
    }
    
    func loadPage() {
        currentPage += 1
        getMovieList { [weak self] movieList in
            self?.movieList = movieList
            self?.presentDisplayMovies(append: true)
        }
    }

}
