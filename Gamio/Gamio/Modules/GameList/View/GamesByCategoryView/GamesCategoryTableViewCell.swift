//
//  GamesCategoryTableViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 16.12.2022.
//

import UIKit
protocol GamesCategoryTableViewCellDelegate: AnyObject {
    func gameCategoryTableViewCellDidTapped(_ cell: GamesCategoryTableViewCell, gameTitle: String)
}

final class GamesCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: Properties
    class var defaultHeight: Double { return 180 }
    weak var delegate: GamesCategoryTableViewCellDelegate?
    var gameCategories: [GameGenre] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(UINib(nibName: "GamesCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GamesCategoryCollectionViewCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: GamesCategoryCollectionViewCell.defaultWidth, height: GamesCategoryCollectionViewCell.defaultHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureCell() {
        cellTitleLabel.text = "browseByGenreText".localized
        collectionView.reloadData()
    }
}

extension GamesCategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesCategoryCollectionViewCell", for: indexPath) as? GamesCategoryCollectionViewCell else {return UICollectionViewCell()}
        cell.cellTitle.text = gameCategories[indexPath.row].localized
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.gameCategoryTableViewCellDidTapped(self, gameTitle: gameCategories[indexPath.row].description)
    }
}
