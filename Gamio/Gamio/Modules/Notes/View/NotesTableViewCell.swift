//
//  NotesTableViewCell.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var notTitle: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configureCell(model: Notes) {
        notTitle.text =  "\("noteTitle".localized):"
        gameImage.layer.cornerRadius = 10
        gameImage.clipsToBounds = true
        guard let url = URL(string: model.gameImage ?? "") else { return }
        gameImage.af.setImage(withURL: url)
        gameImage.contentMode = .scaleAspectFill
        noteLabel.text = model.gameNote
        gameNameLabel.text = model.gameName
    }
}
