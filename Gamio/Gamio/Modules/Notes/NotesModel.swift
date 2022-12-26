//
//  NoteModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import Foundation
struct NotesModel : Decodable {
    
    let id: Int
    let gameId: Int32
    let gameNote : String
    let gameImg: String?
}

enum CodingKeys: String, CodingKey {
    case id
    case gameImg = "background_image"
    case gameId
    case gameNote
}
