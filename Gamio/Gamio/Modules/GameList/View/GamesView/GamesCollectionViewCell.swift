//
//  GamesCollectionViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 11.12.2022.
//

import UIKit
import AlamofireImage
final class GamesCollectionViewCell: UICollectionViewCell {
    class var defaultHeight: CGFloat { return 180 }
    class var defaultWidth: CGFloat { return 380 }
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(model: GameListModel) {
        gameLabel.text = model.name
        guard let url = URL(string:  model.img) else { return }
        gameImage.af.setImage(withURL: url)
        gameImage.contentMode = .scaleAspectFill
    }
    
    func setCell() {
        layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        gameImage.image = nil
    }
}
