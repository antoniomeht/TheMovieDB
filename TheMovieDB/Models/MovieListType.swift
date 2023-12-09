//
//  MovieListType.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import Foundation

enum MovieListType {
    case nowPlaying
    case popular
    case topRated
    case upcomming
    
    func getPath() -> String{
        switch self {
        case .nowPlaying:
            return Constants.Endpoint.Movie.nowPlaying
        case .popular:
            return Constants.Endpoint.Movie.popular
        case .topRated:
            return Constants.Endpoint.Movie.topRated
        case .upcomming:
            return Constants.Endpoint.Movie.upcomming
        }
    }
}
