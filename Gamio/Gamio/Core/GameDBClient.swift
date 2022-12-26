//
//  GameDBClient.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 7.12.2022.
//

import Foundation
import Alamofire

final class GameDBClient {
    static let BASE_URL = "https://api.rawg.io/api/"
    static let IMAGE_BASE_URL = "https://media.rawg.io/media/games/"
    
    static func getGames(completion: @escaping ([GameListModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "games" + "?key=" + Constants.API_KEY + "&page_size=50"
        handleResponse(urlString: urlString, responseType: GetGamesListResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    static func getLatestGames(completion: @escaping ([GameListModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "games" + "?key=" + Constants.API_KEY + "&dates=2022-11-01,2022-12-30&platforms=18,1,7"
        handleResponse(urlString: urlString, responseType: GetGamesListResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    static func getMostRatedGames(completion: @escaping ([GameListModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "games" + "?key=" + Constants.API_KEY + "&dates=2022-01-01,2022-12-31&ordering=-rating"
        handleResponse(urlString: urlString, responseType: GetGamesListResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    static func getGameDetail(gameId: Int, completion: @escaping (GameDetailModel?, Error?) -> Void) {
        let urlString = BASE_URL + "games/" + String(gameId) + "?" + "key=" + Constants.API_KEY
        handleResponse(urlString: urlString, responseType: GameDetailModel.self, completion: completion)
    }
    
    
    static func getGameByCategorie(genre: String, completion: @escaping ([GenreModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "games" + "?key=" + Constants.API_KEY + "&page=100&page_size=50&genres=\(genre)"
        handleResponse(urlString: urlString, responseType: GetGenreResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    static private func handleResponse<T: Decodable>(urlString: String, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        AF.request(urlString).response { response in
            guard let data = response.value else {
                DispatchQueue.main.async {
                    completion(nil, response.error)
                    Alert.sharedInstance.showError()
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                    Alert.sharedInstance.showError()
                }
            }
        }
    }
}
