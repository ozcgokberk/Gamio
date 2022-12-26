//
//  LanguageViewController.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 13.12.2022.
//

import UIKit
import L10n_swift

final class LanguageViewController: UIViewController {
    //MARK: - Properties
    private var viewModel: LanguageViewModelProtocol = LanguageViewModel()
    private let languages: [LanguageEnum] = [.tr, .en]
    //MARK: - Outlet
    @IBOutlet weak var languagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    private func viewSetup() {
        languagesTableView.dataSource = self
        languagesTableView.delegate = self
        languagesTableView.register(UINib(nibName: "LanguageTableViewCell", bundle: nil), forCellReuseIdentifier: "LanguageTableViewCell")
        languagesTableView.separatorColor = .white
        addNavigationBar(title: "languageSettingsText".localized ,presentType: .popAndShowNavBar)
    }
    
    private func setLanguage(selectedLang: LanguageEnum) {
        L10n.shared.language = selectedLang.rawValue.lowercased()
        Alert.sharedInstance.showSuccess()
        NotificationCenter.default.post(name: .RefreshTableView, object: nil)
    }
}
extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getLanguageCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell") as? LanguageTableViewCell else { return UITableViewCell()}
        let selectedLang = languages[indexPath.row]
        cell.languageLabel.text = selectedLang.description
        cell.languageImg.image = selectedLang.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setLanguage(selectedLang: languages[indexPath.row])
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
