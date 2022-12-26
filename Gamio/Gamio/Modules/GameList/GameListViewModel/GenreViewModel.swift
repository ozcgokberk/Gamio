//
//  GenreViewModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 16.12.2022.
//
import Foundation
protocol GenreListViewModelProtocol {
    var delegate: GenreListViewModelDelegate? { get set }
    func getGamesByCategorie(genre: String)
    func getCountOfGames() -> Int?
}

protocol GenreListViewModelDelegate: AnyObject {
    func gamesLoaded(filteredGenre: [GenreModel]?)
}

final class GenreViewModel: GenreListViewModelProtocol {
    
    weak var delegate: GenreListViewModelDelegate?
    private var filteredGenre: [GenreModel]?
    
    func getGamesByCategorie(genre: String) {
        GameDBClient.getGameByCategorie(genre: genre) { [weak self] filteredGenre, error in
            guard let self = self else { return }
            self.filteredGenre = filteredGenre
            self.delegate?.gamesLoaded(filteredGenre: filteredGenre)
        }
    }
    
    func getCountOfGames() -> Int? {
        return filteredGenre?.count
    }
}
