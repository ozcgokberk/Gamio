//
//  AddOrUpdateVC.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 12.12.2022.
//

import UIKit

protocol AddOrUpdateVCProtocol: AnyObject {
    func refresh()
}

final class AddOrUpdateVC: UIViewController {
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNoteTxtView: UITextView!
    @IBOutlet weak var noteTitleLabel: UILabel! {
        didSet {
            noteTitleLabel.text = "noteTitleText".localized
        }
    }
    
    //MARK: Properties
    private var viewModel: NotesViewModelProtocol = NotesListViewModel()
    weak var delegate: AddOrUpdateVCProtocol?
    var selectedNote: Notes?
    var noteArray: [Notes] = []
    var gameId: Int?
    var gameImg: String?
    var gameName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        gameNoteTxtView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }
    
    private func viewSetup() {
        checkIsSelectedNoteExist()
        guard let imgUrl = URL(string: gameImg ?? "") else { return }
        gameImageView.af.setImage(withURL: imgUrl)
        gameImageView.layer.cornerRadius = 10
        gameImageView.clipsToBounds = true
        gameImageView.layer.masksToBounds = true
        gameImageView.contentMode = .scaleAspectFill
        gameNoteTxtView.layer.borderColor = UIColor.white.cgColor;
        gameNoteTxtView.layer.borderWidth = 1.0;
        gameNoteTxtView.layer.cornerRadius = 5.0;
    }
    
    private func configureNavigationBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "\(gameName ?? "")")
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        doneItem.title = "doneTitle".localized
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
    }
    
    private func checkIsSelectedNoteExist() {
        if selectedNote != nil {
            gameImg = selectedNote?.gameImage
            gameNoteTxtView.text = selectedNote?.gameNote
        }
    }
    
    @objc func doneButtonPressed() {
        if gameNoteTxtView.text.isEmpty {
            Alert.sharedInstance.showWarning()
        } else {
            if let guideVC = Constants.storyboard.instantiateViewController(identifier: "NotesViewController") as? NotesViewController {
                guideVC.id = gameId
            }
            if selectedNote == nil {
                noteArray.append(CoreDataManager.shared.saveGameNote(id: UUID().uuidString, gameId: gameId!, gameNote: gameNoteTxtView.text, gameImage: gameImg ?? "", gameName: gameName ?? "")!)
            } else {
                CoreDataManager.shared.noteUpdate(id: selectedNote?.id ?? "", gameId: Int32(gameId ?? 0), gameNote: gameNoteTxtView.text)
            }
            Alert.sharedInstance.showSuccess()
            delegate?.refresh()
            dismiss(animated: true)
        }
    }
}

extension AddOrUpdateVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let text = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = text.count
        return numberOfChars < 200   // 200 Limit Value
    }
}
