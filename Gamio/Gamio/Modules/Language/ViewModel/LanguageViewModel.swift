//
//  LanguageViewModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 17.12.2022.
//

import Foundation


import Foundation
protocol LanguageViewModelProtocol {
    var delegate: LanguageViewModelDelegate? { get set }
    func getLanguageCount() -> Int
}

protocol LanguageViewModelDelegate: AnyObject {
    func languagesLoaded()
}

final class LanguageViewModel: LanguageViewModelProtocol {
    var delegate: LanguageViewModelDelegate?
    private var languages: [LanguageEnum] =  [.en,.tr]
    
    func getLanguageCount() -> Int {
        languages.count 
    }
    
}

