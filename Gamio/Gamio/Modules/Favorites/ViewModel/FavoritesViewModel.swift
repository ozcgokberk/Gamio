//
//  FavoritesViewModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 14.12.2022.
//



import Foundation
import CoreData

protocol FavoritesViewModelProtocol {
    var delegate: FavoritesViewModelDelegate? { get set }
    func fetchFavorites()
    func getFavoritesCount() -> Int?
}
protocol FavoritesViewModelDelegate: AnyObject {
    func favoritesLoaded(favorites: [Favorites])
}

final class FavoritesViewModel:  FavoritesViewModelProtocol {
    
    weak var delegate: FavoritesViewModelDelegate?
    private var favorites: [Favorites]?
    private var game: GameDetailModel?
    
    
    func fetchFavorites() {
        favorites = CoreDataManager.shared.getFavorites()
        delegate?.favoritesLoaded(favorites: favorites ?? [])
    }
    
    func getFavoritesCount() -> Int? {
        favorites?.count
    }
}
