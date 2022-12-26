//
//  GetGenreResponseModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 16.12.2022.
//

import Foundation
struct GetGenreResponseModel: Decodable {
    let results: [GenreModel]
}
