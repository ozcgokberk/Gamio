//
//  FavoritesViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var emptyFavoriteView: EmptyNoteView?
    var gameId: Int?
    var gameImg: String?
    var gameName: String?
    var gameRate: Double?
    var favorites: [Favorites] = []
    
  
    private var viewModel: FavoritesViewModelProtocol = FavoritesViewModel()
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchFavorites()
        checkIfNoteExist()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emptyFavoriteView?.removeFromSuperview()
    }
    
    private func configureTableView() {
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesTableViewCell")
        favoritesTableView.separatorColor = .white
        
    }
    
    private func checkIfNoteExist() {
        if favorites.count == 0 {
            addEmptyNoteView()
        }
    }
    
    private func addEmptyNoteView() {
        guard let emptyView = UINib(nibName: "EmptyNoteView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? EmptyNoteView else { return }
        self.emptyFavoriteView = emptyView
        self.emptyFavoriteView?.frame = self.favoritesTableView.bounds
        self.favoritesTableView.addSubview(self.emptyFavoriteView ?? UIView())
    }
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell") as? FavoritesTableViewCell else { return UITableViewCell() }
        cell.configureCell(model: favorites[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteButton = UIContextualAction(style: .destructive, title: "deleteText".localized) {  (contextualAction, view, boolValue) in
            CoreDataManager.shared.managedContext.delete(self.favorites[indexPath.row])
            self.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            do {
                try CoreDataManager.shared.managedContext.save()
                Alert.sharedInstance.showSuccess()
                self.checkIfNoteExist()
                tableView.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                Alert.sharedInstance.showWarning()
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteButton])
        return swipeActions
    }
}
extension FavoritesViewController: FavoritesViewModelDelegate {
    func favoritesLoaded(favorites: [Favorites]) {
        self.favorites = favorites
        favoritesTableView.reloadData()
    }
}
extension FavoritesViewController: GameDetailVCProtocol {
    func refresh() {
        favorites = CoreDataManager.shared.getFavorites()
        favoritesTableView.reloadData()
    }
}
