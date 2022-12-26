//
//  EmptyNoteView.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 18.12.2022.
//

import UIKit

class EmptyNoteView: UIView {
    
    @IBOutlet weak var noNoteImage: UIImageView! {
        didSet {
            noNoteImage.image = UIImage(named: "emptyView")
        }
    }
    
    @IBOutlet weak var noNoteTitle: UILabel! {
        didSet {
            noNoteTitle.text = "emptyViewText".localized
        }
    }
    
}
