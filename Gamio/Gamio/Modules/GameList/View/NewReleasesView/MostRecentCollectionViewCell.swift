//
//  MostRecentCollectionViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 8.12.2022.
//

import UIKit
import AlamofireImage

final class MostRecentCollectionViewCell: UICollectionViewCell {
    
    class var defaultHeight: CGFloat { return 180 }
    class var defaultWidth: CGFloat { return 380 }
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(model: GameListModel) {
        gameNameLabel.text = model.name
        guard let url = URL(string:  model.img) else { return }
        gameImage.af.setImage(withURL: url)
        gameImage.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        gameImage.image = nil
    }
}
