//
//  APIManager+MovieList.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import Foundation

extension APIManager {
    func getMovies(listType: MovieListType, parameters: [String: Any]?, completion: @escaping (Result<MovieList, Error>) -> Void) {
        request(endpoint: listType.getPath(), method: .GET, parameters: parameters, completion: completion)
    }
}
