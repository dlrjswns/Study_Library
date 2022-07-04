//
//  PopularMovieList.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/07/04.
//

import Foundation

struct PopularMovieList: Decodable {
    let page: Int
    let popularMovieList: [PopularMovie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case popularMovieList = "results"
    }
}

struct PopularMovie: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int?
    let orivinalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Float?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult, id, overview, popularity, title, video
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case orivinalLanguage = "orivinal_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.adult = try? values.decode(Bool.self, forKey: .adult)
        self.backdropPath = try? values.decode(String.self, forKey: .backdropPath)
        self.genreIds = try? values.decode([Int].self, forKey: .genreIds)
        self.id = try? values.decode(Int.self, forKey: .id)
        self.orivinalLanguage = try? values.decode(String.self, forKey: .orivinalLanguage)
        self.originalTitle = try? values.decode(String.self, forKey: .originalTitle)
        self.overview = try? values.decode(String.self, forKey: .overview)
        self.popularity = try? values.decode(Double.self, forKey: .popularity)
        self.posterPath = try? values.decode(String.self, forKey: .posterPath)
        self.releaseDate = try? values.decode(String.self, forKey: .releaseDate)
        self.title = try? values.decode(String.self, forKey: .title)
        self.video = try? values.decode(Bool.self, forKey: .video)
        self.voteAverage = try? values.decode(Float.self, forKey: .voteAverage)
        self.voteCount = try? values.decode(Int.self, forKey: .voteCount)
    }
}





