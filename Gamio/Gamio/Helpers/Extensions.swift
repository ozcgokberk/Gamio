//
//  Extensions.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 26.12.2022.
//

import UIKit
import L10n_swift

extension String {
    func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
    }
    
    var localized: String {
        return self.l10n()
    }
}

extension Notification.Name {
    static let RefreshTableView = Notification.Name(rawValue: "refreshTableView")
    static let RefreshGamesTableView = Notification.Name(rawValue: "refreshGamesTableView")
}

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        return dateFormatter.string(from: self)
    }
}

extension UIViewController {
    
    func setNavigationBar(willShowBackButton: Bool, title: String, isMedias: Bool = false, isFolderSelection: Bool = false) {
        guard let vcNavigationController = self.navigationController else { return }
        
        let customBar: UINavigationBar = UINavigationBar()
        
        
        customBar.frame = vcNavigationController.navigationBar.bounds
        customBar.barTintColor = .white
        customBar.backgroundColor = .white
        vcNavigationController.navigationBar.barTintColor = .white
        
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.isUserInteractionEnabled = true
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        customBar.addSubview(backButton)
        
        let navigationTitle = UILabel()
        navigationTitle.font = UIFont(name: "Arial", size: 15)
        navigationTitle.textColor = .red
        navigationTitle.text = title
        navigationTitle.contentMode = .scaleToFill
        navigationTitle.numberOfLines = 2
        navigationTitle.textAlignment = .center
        navigationTitle.lineBreakMode = .byWordWrapping
        navigationTitle.translatesAutoresizingMaskIntoConstraints = false
        customBar.addSubview(navigationTitle)
        
        vcNavigationController.navigationItem.setHidesBackButton(true, animated: true)
        vcNavigationController.navigationBar.addSubview(customBar)
        
        backButton.leftAnchor.constraint(equalTo: customBar.leftAnchor, constant: 20.0).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        navigationTitle.widthAnchor.constraint(equalToConstant: vcNavigationController.navigationBar.bounds.width / 1.5).isActive = true
        
        let checkCenterY = NSLayoutConstraint(item: backButton, attribute: .centerY, relatedBy: .equal, toItem: customBar, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        let keyNameCenterY = NSLayoutConstraint(item: navigationTitle, attribute: .centerY, relatedBy: .equal, toItem: customBar, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let keyNameCenterX = NSLayoutConstraint(item: navigationTitle, attribute: .centerX, relatedBy: .equal, toItem: customBar, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([checkCenterY, keyNameCenterY, keyNameCenterX])
        
        if willShowBackButton {
            backButton.isHidden = false
            if !isMedias {
                backButton.addTarget(self, action: #selector(self.popViewControllerAndHideNavigationBar), for: .touchUpInside)
            } else if isFolderSelection && isMedias {
                backButton.addTarget(self, action: #selector(self.popViewControllerAndShowNavigationBar), for: .touchUpInside)
            } else {
                backButton.addTarget(self, action: #selector(self.dismissVC), for: .touchUpInside)
            }
        } else {
            backButton.isHidden = true
        }
    }
    
    func removeNavigationBar(removeAllSubviews: Bool = false){
        if removeAllSubviews {
            self.navigationController?.navigationBar.subviews.forEach({
                $0.removeFromSuperview()
            })
        } else {
            self.navigationController?.navigationBar.subviews.last?.removeFromSuperview()
        }
    }
    
    @objc func popViewControllerAndHideNavigationBar() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func popViewControllerAndShowNavigationBar() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    func addNavigationBar(title: String?,
                          presentType: LeftButtonBehaviorType = .dismiss,
                          rightButton rAttributes: NavBarButtonAttributes? = nil,
                          leftButton lAttributes: NavBarButtonAttributes? = NavBarButtonAttributes(image: UIImage(named: "backButton"), title: nil, action: #selector(dismissVC), tintColor: .white)) {
        self.navigationItem.title = title
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.backgroundColor = UIColor(rgb: 0x17255F)
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "Arial", size: 18)!
        ]
        
        if presentType != .none {
            if let leftItem = lAttributes,
               let leftAction = leftItem.action,
               let leftItemColor = leftItem.tintColor {
                var leftButtonAction: Selector? = leftAction
                if presentType == .popAndShowNavBar {
                    leftButtonAction = #selector(popViewControllerAndShowNavigationBar)
                } else if presentType == .popAndHideNavBar {
                    leftButtonAction = #selector(popViewControllerAndHideNavigationBar)
                }
                if let withImage = leftItem.image {
                    self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: withImage,
                                                                            style: .plain,
                                                                            target: self,
                                                                            action: leftButtonAction)
                } else if let withTitle = leftItem.title {
                    self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: withTitle,
                                                                            style: .plain,
                                                                            target: self,
                                                                            action: leftButtonAction)
                    self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([
                        .foregroundColor: leftItemColor,
                        .font: UIFont(name: "Arial", size: 15)!,
                    ], for: .normal)
                    self.navigationItem.leftBarButtonItem?.setTitleTextAttributes([
                        .foregroundColor: leftItemColor,
                        .font: UIFont(name: "Arial", size: 15)!,
                    ], for: .selected)
                }
            }
            
            if let leftItem = lAttributes, let leftItemColor = leftItem.tintColor {
                self.navigationItem.leftBarButtonItem?.tintColor = leftItemColor
            }
        }
        
        if let rightItem = rAttributes,
           let rightAction = rightItem.action {
            if let withImage = rightItem.image {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: withImage,
                                                                         style: .plain,
                                                                         target: self,
                                                                         action: rightAction)
            } else if let withTitle = rightItem.title {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: withTitle,
                                                                         style: .plain,
                                                                         target: self,
                                                                         action: rightAction)
                self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
                    .foregroundColor: UIColor.white,
                    .font: UIFont(name: "Arial", size: 15)!
                ], for: .normal)
                self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([
                    .foregroundColor: UIColor.white,
                    .font: UIFont(name: "Arial", size: 15)!
                ], for: .selected)
            }
            
            self.navigationItem.rightBarButtonItem?.tintColor = .white
        }
    }
}

struct NavBarButtonAttributes {
    var image: UIImage?
    var title: String?
    var action: Selector?
    var tintColor: UIColor?
    
    init(image: UIImage? = nil, title: String? = nil, action: Selector? = nil, tintColor: UIColor? = nil) {
        self.image = image
        self.title = title
        self.action = action
        self.tintColor = tintColor
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
