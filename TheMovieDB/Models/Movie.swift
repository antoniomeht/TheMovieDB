//
//  Movie.swift
//  TheMovieDB
//
//  Created by Antonio Araez Moreno on 9/12/23.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let genres: [MovieGenre]?
    let releaseDate: String?
    let popularity: Double?
    let voteCount: Int?
    let voteAverage: Double?
    let video: Bool?
    let adult: Bool?
    let originalLanguage: String?
    let originalTitle: String?
    let runtime: Int?
    let production: [ProductionCompanies]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genres
        case releaseDate = "release_date"
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case video
        case adult
        case originalLanguage = "original_laguage"
        case originalTitle = "original_title"
        case runtime
        case production = "production_companies"
    }
    
    var backdropURL: URL {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
        return url
    }
    
    var posterURL: URL {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
        return url
    }
    
    var mainGenre: String{
        return genres?.first?.name ?? StringConstants.Utils.unknownGenre
    }
    
    var yearString: String{
        return Utils.movieDateString(from: releaseDate ?? .empty)
    }
    
    var movieDuration: String{
        return Utils.durationString(time: runtime)
    }
}

struct MovieGenre: Codable{
    
    let id: Int?
    let name: String?

}

struct ProductionCompanies: Codable, Identifiable{
    
    let name: String?
    let id: Int?
    
}
