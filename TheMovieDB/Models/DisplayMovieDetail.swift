//
//  DisplayMovieDetail.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 12/12/23.
//

import Foundation

struct DisplayMovieDetail {
    let id: Int?
    let title: String?
    let overview: String?
    let backdropPath: URL?
    let genres: [MovieGenre]?
    let releaseDate: String?
    let popularity: Double?
    let adult: Bool?
    let movieDuration: String?
    let voteCount: Int?
    let voteAverage: Double?
    let production: [ProductionCompanies]?
}
