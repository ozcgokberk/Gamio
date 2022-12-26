//
//  GenreListCollectionViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 16.12.2022.
//

import UIKit

final class GenreListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell()
    }
    
    func configureCell(with model: GenreModel) {
        gameName.text = model.name
        guard let url = URL(string:  model.img) else { return }
        gameImage.af.setImage(withURL: url)
        gameImage.contentMode = .scaleAspectFill
    }
    
    func setCell() {
        layer.cornerRadius = 15
    }
    
    override func prepareForReuse() {
        gameImage.image = nil
    }
}
