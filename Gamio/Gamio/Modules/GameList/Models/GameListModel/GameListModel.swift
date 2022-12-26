//
//  GameListModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import Foundation
struct GameListModel: Codable {
    
    let id: Int
    let slug: String
    let name: String
    let released : String
    let img: String
    let rating: Double
    let ratingCount: Int
    let playTime: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case img = "background_image"
        case rating = "rating"
        case ratingCount = "ratings_count"
        case playTime = "playtime"
    }
}
