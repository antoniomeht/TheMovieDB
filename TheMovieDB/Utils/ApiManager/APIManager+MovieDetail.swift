//
//  APIManager+MovieDetail.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 12/12/23.
//

import Foundation

extension APIManager {
    func getMovieDetail(movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        request(endpoint: Constants.Endpoint.Movie.detail + "\(movieId)" , method: .GET, parameters: nil, completion: completion)
    }
}
