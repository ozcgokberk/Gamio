//
//  GenreViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 16.12.2022.
//

import UIKit

final class GenreViewController: UIViewController {
    private var viewModel: GenreListViewModelProtocol = GenreViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    var genre: String?
    private var gameList: [GenreModel] = []
    
    override func viewDidLoad() {
        showBlockingActivityIndicator()
        super.viewDidLoad()
        viewModel.getGamesByCategorie(genre: genre ?? "")
        viewModel.delegate = self
        setupCollectionView()
        addNavigationBar(title: genre, presentType: .popAndShowNavBar)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GenreListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreListCollectionViewCell")
    }

}
extension GenreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getCountOfGames() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreListCollectionViewCell", for: indexPath) as? GenreListCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(with: gameList[indexPath.row])
        cell.layer.cornerRadius = 15
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let guideVC = Constants.storyboard.instantiateViewController(identifier: "GameDetailViewController") as? GameDetailViewController {
            guideVC.gameId = gameList[indexPath.row].id
            navigationController?.pushViewController(guideVC, animated: true)
        }

    }
    
}

extension GenreViewController: GenreListViewModelDelegate {
    func gamesLoaded(filteredGenre: [GenreModel]?) {
        self.gameList = filteredGenre ?? []
        collectionView.reloadData()
        hideBlockingActivityIndicator()
    }
}
