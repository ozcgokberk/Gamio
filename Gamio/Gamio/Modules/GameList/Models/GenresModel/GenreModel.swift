//
//  GenreModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 16.12.2022.
//

import Foundation
struct GenreModel: Codable {
    
    let name: String
    let img: String
    let id: Int
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case img = "background_image"
        case id
        case rating
    }
}
