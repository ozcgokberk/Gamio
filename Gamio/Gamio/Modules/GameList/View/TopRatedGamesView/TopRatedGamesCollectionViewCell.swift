//
//  TopRatedGamesCollectionViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 11.12.2022.
//

import UIKit

final class TopRatedGamesCollectionViewCell: UICollectionViewCell {
    class var defaultHeight: CGFloat { return 180 }
    class var defaultWidth: CGFloat { return 380 }
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameRate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(model: GameListModel) {
        gameNameLabel.text = model.name
        guard let url = URL(string:  model.img) else { return }
        gameImage.af.setImage(withURL: url)
        gameImage.contentMode = .scaleAspectFill
        gameRate.text = "\(model.rating)/5"
    }
    
    func setCell() {
        layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        gameImage.image = nil
    }

}
