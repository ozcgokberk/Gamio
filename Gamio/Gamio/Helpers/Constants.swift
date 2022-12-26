//
//  Constants.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import UIKit

struct Constants {
    static let API_KEY = "c3eccb944689454da36e586efd3f3259"
    static func removeHTMLTags(in overview: String) -> String? {
        overview.trimHTMLTags()
    }
    static let storyboard = UIStoryboard(name: "Main", bundle: nil)
}
