//
//  ActivityIndicator.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 15.12.2022.
//

import UIKit
import NVActivityIndicatorView
final class ActivityIndicator: UIView {
    private let activityIndicator: NVActivityIndicatorView
    override init(frame: CGRect) {
        self.activityIndicator = NVActivityIndicatorView(
            frame: CGRect(
                origin: .zero,
                size: NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE
                
            ),
            type: .ballClipRotate,
            color: (.white)
        )
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        super.init(frame: frame)
        addSubview(activityIndicator)
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -50.0)
            ])
        } else {
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
        }
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension UIViewController {
    func showBlockingActivityIndicator() {
        guard !self.view.subviews.contains(where: { $0 is ActivityIndicator }) else {
            return
        }
        let activityIndicator = ActivityIndicator()
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicator.frame = self.view.frame
        UIView.transition(
            with: self.view,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
                self.view.addSubview(activityIndicator)
            }
        )
        self.view.isUserInteractionEnabled = false
    }
    
    func hideBlockingActivityIndicator() {
        let views = self.view.subviews.filter { $0 is ActivityIndicator }
        views.forEach { (activity) in
            (activity as? ActivityIndicator)?.stopAnimating()
        }
        self.view.isUserInteractionEnabled = true
    }
}
