//
//  SeeAllGamesVC.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 15.12.2022.
//

import UIKit

final class SeeAllGamesVC: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "searchText".localized
        }
    }
    @IBOutlet weak var allGamesTableView: UITableView!
    //MARK: Properties
    var allGames: [GameListModel] = []
    private var searchedGames: [GameListModel] = []
    private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        searchBar.delegate = self
    }
    
    private func configureTableView() {
        allGamesTableView.separatorColor = .white
        allGamesTableView.dataSource = self
        allGamesTableView.delegate = self
        allGamesTableView.register(UINib(nibName: "AllGamesTableViewCell", bundle: nil), forCellReuseIdentifier: "AllGamesTableViewCell")
    }
}

extension SeeAllGamesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
           return searchedGames.count
        } else {
            return allGames.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllGamesTableViewCell") as? AllGamesTableViewCell else { return UITableViewCell() }
        if isSearching {
            cell.configureCell(model: searchedGames[indexPath.row])
        } else {
            cell.configureCell(model: allGames[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let guideVC = Constants.storyboard.instantiateViewController(identifier: "GameDetailViewController") as? GameDetailViewController {
            if isSearching {
                guideVC.gameId = searchedGames[indexPath.row].id
            } else {
                guideVC.gameId = allGames[indexPath.row].id
            }
            navigationController?.pushViewController(guideVC, animated: true)
        }
    }
}

extension SeeAllGamesVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        searchedGames = allGames
        searchBar.showsCancelButton = true
        allGamesTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchedGames = []
        isSearching = false
        searchBar.setValue("cancelButtonText".localized, forKey: "cancelButtonText")
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        dismiss(animated: true, completion: nil)
        allGamesTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.lowercased() == "" {
            searchedGames = allGames
            allGamesTableView.reloadData()
        } else {
            searchedGames = allGames.filter({ games in
                games.name.lowercased().contains((searchBar.text?.lowercased())!)
            })
            allGamesTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        allGamesTableView.reloadData()
    }
}
