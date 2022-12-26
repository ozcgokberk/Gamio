//
//  GamesTableViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 11.12.2022.
//

import UIKit
protocol GamesTableViewCellDelegate: AnyObject {
    func gamesTableViewCellDidTapped(_ cell: GamesTableViewCell, game: GameListModel)
    func seeAllButtonPressed()
}

final class GamesTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var allGamesLabel: UILabel!
    @IBOutlet weak var seeAllButton: UIButton!
    
    //MARK: Properties
    var allGames: [GameListModel] = []
    weak var delegate: GamesTableViewCellDelegate?
    class var defaultHeight: Double { return 200 }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGamesTableView), name: .RefreshGamesTableView, object: nil)
        
        seeAllButton.layer.borderWidth = 1.0
        seeAllButton.layer.cornerRadius = 15
        seeAllButton.layer.borderColor = UIColor.white.cgColor
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        selectionStyle = .none
        collectionView.register(UINib(nibName: "GamesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GamesCollectionViewCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: GamesCollectionViewCell.defaultWidth, height: MostRecentCollectionViewCell.defaultHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    func configureCell() {
        allGamesLabel.text = "allGames".localized
        seeAllButton.setTitle("seeAllText".localized, for: .normal)
    }
    
    @IBAction func seeAllButtonPressed(_ sender: Any) {
        delegate?.seeAllButtonPressed()
    }
    
    @objc func refreshGamesTableView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension GamesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesCollectionViewCell", for: indexPath) as? GamesCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(model: allGames[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.gamesTableViewCellDidTapped(self, game: allGames[indexPath.row])
    }
}
