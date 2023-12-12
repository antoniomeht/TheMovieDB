//
//  APIManager+SearchMovie.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 12/12/23.
//

import Foundation

extension APIManager {
    func searchMovie(with query: String, page: Int, completion: @escaping (Result<MovieList, Error>) -> Void) {
        request(endpoint: Constants.Endpoint.Movie.search + "?query=\(query)" + "&page=\(page)" , method: .GET, parameters: nil, completion: completion)
    }
}
