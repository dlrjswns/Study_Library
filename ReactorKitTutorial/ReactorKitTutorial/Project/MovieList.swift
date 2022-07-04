//
//  MovieList.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/07/04.
//


struct MovieList: Decodable {
    let lastBuildDate: String?
    let total: Int?
    let start: Int?
    let display: Int?
    let items: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case lastBuildDate, total, start, display, items
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.lastBuildDate = try? values.decode(String.self, forKey: .lastBuildDate)
        self.total = try? values.decode(Int.self, forKey: .total)
        self.start = try? values.decode(Int.self, forKey: .start)
        self.display = try? values.decode(Int.self, forKey: .display)
        self.items = try? values.decode([Movie].self, forKey: .items)
    }
}

struct Movie: Decodable {
    let title: String
    let link: String
    let image: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
}







