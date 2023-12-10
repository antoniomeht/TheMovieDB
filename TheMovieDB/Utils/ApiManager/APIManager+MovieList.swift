//
//  APIManager+MovieList.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import Foundation

extension APIManager {
    func getMovies(listType: MovieListType, page: Int, completion: @escaping (Result<MovieList, Error>) -> Void) {
        request(endpoint: listType.getPath() + "?page=\(page)", method: .GET, parameters: nil, completion: completion)
    }
}
