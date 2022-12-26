//
//  GetPopularGamesResponseModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import Foundation
struct GetGamesListResponseModel: Decodable {
    let results: [GameListModel]
}
