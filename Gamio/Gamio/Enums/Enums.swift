//
//  Enums.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 9.12.2022.
//

import Foundation
import UIKit

enum SortMenu: Int {
    
    case sortByName = 0
    case sortByRatinCount = 1
    case sortByReleased = 2
    case sortyByPlaytime = 3
    
    var description: String {
        switch self {
        case .sortByName:
            return "sortByNameTxt".localized
        case .sortByRatinCount:
            return "sortByRatingCountTxt".localized
        case .sortByReleased:
            return "sortByReleasedTxt".localized
        case .sortyByPlaytime:
            return "sortByPlaytimeTxt".localized
        }
    }
}

enum HomeSectionType: Int, CaseIterable {
    case newGames = 0
    case allGames = 1
    case topRatedGames = 2
    case gameCategories = 3
    
    var descripton: String {
        switch self {
        case .newGames:
            return "new games"
        case .allGames:
            return "all games"
        case .topRatedGames:
            return "top rated games"
        case .gameCategories:
            return "gameCategories"
        }
    }
}

enum LanguageEnum: String {
    case tr = "TR"
    case en = "EN"
    
    var description: String {
        switch self {
        case .tr:
            return "Turkish"
        case .en:
            return "English"
        }
    }
    var image: UIImage {
        switch self {
        case .tr:
            return UIImage(named: "turkiye")!
        case .en:
            return UIImage(named: "english")!
        }
    }
}

enum GameGenre: String {
    
    case action
    case casual
    case shooter
    case adventure
    case fantasy
    case simulation
    
    var localized: String {
        switch self {
        case .action:
            return "actionText".localized
        case .adventure:
            return "adventureText".localized
        case .casual:
            return "casualText".localized
        case .shooter:
            return "shooterText".localized
        case .fantasy:
            return "fantasyText".localized
        case .simulation:
            return "simulationText".localized
        }
    }
    
    var description: String {
        switch self {
        case .action:
            return "action"
        case .adventure:
            return "adventure"
        case .casual:
            return "casual"
        case .shooter:
            return "shooter"
        case .fantasy:
            return "51"
        case .simulation:
            return "simulation"
        }
    }
}

enum CommonLocalization {
    case success
    case successContentText
    case error
    case warning
    case errorOccured
    case errorOccuredParsing
    case mustInput
    case done
    
    
    var localized: String {
        switch self {
        case .success:
            return "successText".localized
        case .successContentText:
            return "successContentText".localized
        case .error:
            return "errorText".localized
        case .warning:
            return "warningText".localized
        case .errorOccured:
            return "errorContentText".localized
        case .errorOccuredParsing:
            return "dataParseErrorText".localized
        case .mustInput:
            return "emptyInput".localized
        case .done:
            return "doneText".localized
        }
    }
}

enum LeftButtonBehaviorType {
    case none
    case popAndShowNavBar
    case popAndHideNavBar
    case dismiss
}
