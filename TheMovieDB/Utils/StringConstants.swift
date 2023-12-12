//
//  StringConstants.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import Foundation

enum StringConstants {
    
    struct MovieList {
        static let title = "movieList.title".localize()
        
        struct ListType {
            static let nowPlaying = "movieList.movieListType.nowPlaying".localize()
            static let popular = "movieList.movieListType.popular".localize()
            static let topRated = "movieList.movieListType.topRated".localize()
            static let upcoming = "movieList.movieListType.upcoming".localize()
        }
    }
    
    struct MovieDetail {
        static let title = "movieDetail.title".localize()
    }
    
    struct Utils {
        static let unknownTime = "utils.unknownTime".localize()
        static let unknownDate = "utils.unknownDate".localize()
        static let unknownGenre = "utils.unknownGenre".localize()
    }
}
