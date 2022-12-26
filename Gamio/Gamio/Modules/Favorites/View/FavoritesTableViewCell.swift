//
//  FavoritesTableViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(model: Favorites) {
        gameImage.layer.cornerRadius = 10
        gameImage.clipsToBounds = true
        name.text = model.gameName
        rating.text = "\(model.gameRate) / 5"
        guard let url = URL(string:  model.gameImg ?? "") else { return }
        gameImage.af.setImage(withURL: url)

    }

   
    
}
