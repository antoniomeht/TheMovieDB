//
//  Constants.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import Foundation

struct Constants {
    
    // MARK: - APIRequest
    
    struct Endpoint{
        static let baseUrl = "https://api.themoviedb.org/3"
        
        struct Movie {
            static let nowPlaying = "/movie/now_playing"
            static let popular = "/movie/popular"
            static let topRated = "/movie/top_rated"
            static let upcomming = "/movie/upcoming"
            static let search = "/search/movie"
            
            /// /movie/{movieId}
            static let detail = "/movie/"
        }
        
    }
    
}
