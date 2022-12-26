//
//  GameDetailViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 11.12.2022.
//

import UIKit
protocol GameDetailVCProtocol: AnyObject {
    func refresh()
}

final class GameDetailViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var imgAdditional: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var metacritic: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var ratingValue: UILabel!
    @IBOutlet weak var releaseValue: UILabel!
    @IBOutlet weak var genreValue: UILabel!
    @IBOutlet weak var metacriticValue: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    //MARK: -Properties
    
    weak var delegate: GameDetailVCProtocol?
    private var viewModel: GameDetailViewModelProtocol = GameDetailViewModel()
    var gameId: Int?
    private var imageUrl: String? {
        return viewModel.getGameImageUrl()
    }
    
    private var gameName: String? {
        return viewModel.getGameName()
    }
    
    private var gameRate: Double? {
        return viewModel.getRating()
    }
    private var favoritedGames: [Favorites] = []
    
    override func viewDidLoad() {
        viewSetup()
        super.viewDidLoad()
        guard let id = gameId else { return }
        viewModel.delegate = self
        viewModel.fetchGameDetail(id: id)
    }
    
    private func viewSetup() {
        showBlockingActivityIndicator()
        releaseDate.text = "releasedText".localized
        rating.text = "rateText".localized
        metacritic.text = "metacriticText".localized
        addNoteButton.setTitle("addNoteText".localized, for: .normal)
        favoriteButton.setTitle("likeItText".localized, for: .normal)
        genres.text = "genresText".localized
        overview.text = "overviewText".localized
        addNavigationBar(title: "gameDetailText".localized, presentType: .popAndShowNavBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CoreDataManager.shared.ifFavoritesExist(gameId: Int32(gameId!)) {
            favoriteButton.setImage(UIImage(named: "favoriteWhiteFilled"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favoriteWhiteEmpty"), for: .normal)
        }
    }
    
    @IBAction func addNotePressed(_ sender: Any) {
        if let addOrUpdateVC = Constants.storyboard.instantiateViewController(identifier: "AddOrUpdateVC") as? AddOrUpdateVC {
            addOrUpdateVC.gameId = gameId
            addOrUpdateVC.gameImg = imageUrl
            addOrUpdateVC.gameName = gameName
            present(addOrUpdateVC, animated: true)
        }
    }
    
    @IBAction func addFavoritesButtonPressed(_ sender: Any) {
        if !CoreDataManager.shared.ifFavoritesExist(gameId: Int32(gameId!)) {
            if let guideVC = Constants.storyboard.instantiateViewController(identifier: "FavoritesViewController") as? FavoritesViewController {
                guideVC.gameName = gameName
                guideVC.gameImg = imageUrl
                guideVC.gameId = gameId
                guideVC.gameRate = gameRate
            }
            favoritedGames.append(CoreDataManager.shared.saveFavorites(id: UUID().uuidString, gameId: Int32(gameId!), gameImg: imageUrl ?? "", gameName: gameName ?? "", gameRate: gameRate ?? 0)!)
            favoriteButton.setImage(UIImage(named: "favoriteWhiteFilled"), for: .normal)
            Alert.sharedInstance.showSuccess()
            delegate?.refresh()
            
        } else {
            CoreDataManager.shared.deleteSingleFavorite(gameId: Int32(gameId!))
            Alert.sharedInstance.showSuccess()
            favoriteButton.setImage(UIImage(named: "favoriteWhiteEmpty"), for: .normal)
        }
    }
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameDetailLoaded() {
        guard let imgUrl = URL(string: imageUrl ?? "") else { return }
        img.af.setImage(withURL: imgUrl)
        guard let imgAdditionalUrl = viewModel.getAdditionalImageUrl() else { return }
        imgAdditional.af.setImage(withURL: imgAdditionalUrl)
        gameNameLabel.text = gameName
        releaseValue.text = "📆 \(viewModel.getReleasedDate())"
        genreValue.text = viewModel.getGenres().first?.name
        ratingValue.text = "⭐️ \(gameRate ?? 0)/5"
        metacriticValue.text = "\(viewModel.getMetacritic())/100"
        descriptionLabel.text = Constants.removeHTMLTags(in: "\(viewModel.getDescription())")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.hideBlockingActivityIndicator()
        }
    }
}
