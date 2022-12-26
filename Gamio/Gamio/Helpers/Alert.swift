//
//  Alert.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 15.12.2022.
//
//

import UIKit
import SwiftEntryKit

final class Alert: NSObject {
    static let sharedInstance = Alert()
    let alertSize = CGSize(width: 35.0, height: 35.0)
    
    func showError(title: String = CommonLocalization.error.localized, message: String = CommonLocalization.errorOccured.localized, duration: Double = 3) {
        let alertTitle: String = title.localized
        let alertMessage: String = message.localized
        var attributes = EKAttributes()
        attributes = .topFloat
        attributes.displayDuration = duration
        attributes.entryBackground = EKAttributes.BackgroundStyle.color(color: EKColor(.red))
        attributes.screenInteraction = .dismiss
        attributes.windowLevel = .custom(level: UIWindow.Level.alert + 1)
        DispatchQueue.main.async {
            attributes.positionConstraints.verticalOffset = UIApplication.shared.statusBarFrame.size.height * 1.3
        }
        
        let image = EKProperty.ImageContent.init(image: UIImage(named: "failed")!, size: alertSize)
        
        let titleLabel = EKProperty.LabelContent.init(
            text: alertTitle,
            style: EKProperty.LabelStyle.init(
                font: UIFont.boldSystemFont(ofSize: 18),
                color: EKColor(.white)
            )
        )
        
        let descriptionLabel = EKProperty.LabelContent.init(
            text: alertMessage,
            style: EKProperty.LabelStyle.init(
                font: UIFont(name: "Arial", size: 15)!,
                color: EKColor(.white)
            )
        )
        
        let simpleMessage = EKSimpleMessage(image: image, title: titleLabel, description: descriptionLabel)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    func showSuccess(title: String = CommonLocalization.success.localized, message: String = CommonLocalization.successContentText.localized, duration: Double = 3) {
        let alertTitle: String = title.localized
        let alertMessage: String = message.localized
        var attributes = EKAttributes()
        attributes = .topFloat
        attributes.displayDuration = duration
        attributes.entryBackground = EKAttributes.BackgroundStyle.color(color: EKColor(.systemGreen))
        attributes.screenInteraction = .dismiss
        attributes.windowLevel = .custom(level: UIWindow.Level.alert + 1)
        DispatchQueue.main.async {
            attributes.positionConstraints.verticalOffset = UIApplication.shared.statusBarFrame.size.height * 1.3
        }
        
        let image = EKProperty.ImageContent.init(image: UIImage(named: "done")!, size: alertSize)
        
        let titleLabel = EKProperty.LabelContent.init(
            text: alertTitle,
            style: EKProperty.LabelStyle.init(
                font: UIFont.boldSystemFont(ofSize: 18),
                color: EKColor(.white)
            )
        )
        
        let descriptionLabel = EKProperty.LabelContent.init(
            text: alertMessage,
            style: EKProperty.LabelStyle.init(
                font: UIFont(name: "Arial", size: 15)!,
                color: EKColor(.white)
            )
        )
        
        let simpleMessage = EKSimpleMessage(image: image, title: titleLabel, description: descriptionLabel)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    func showWarning(title: String = CommonLocalization.warning.localized, message: String = CommonLocalization.mustInput.localized , duration: Double = 3) {
        let alertTitle: String = title.localized
        let alertMessage: String = message.localized
        
        var attributes = EKAttributes()
        attributes = .topFloat
        attributes.displayDuration = duration
        attributes.entryBackground = EKAttributes.BackgroundStyle.color(color: EKColor(.systemYellow))
        attributes.screenInteraction = .dismiss
        attributes.windowLevel = .custom(level: UIWindow.Level.alert + 1)
        DispatchQueue.main.async {
            attributes.positionConstraints.verticalOffset = UIApplication.shared.statusBarFrame.size.height * 1.3
        }
        
        let image = EKProperty.ImageContent.init(image: UIImage(named: "warning")!, size: alertSize)
        
        let titleLabel = EKProperty.LabelContent.init(
            text: alertTitle,
            style: EKProperty.LabelStyle.init(
                font: UIFont.boldSystemFont(ofSize: 18),
                color: EKColor(.white)
            )
        )
        
        let descriptionLabel = EKProperty.LabelContent.init(
            text: alertMessage,
            style: EKProperty.LabelStyle.init(
                font: UIFont(name: "Arial", size: 15)!,
                color: EKColor(.white)
            )
        )
        
        let simpleMessage = EKSimpleMessage(image: image, title: titleLabel, description: descriptionLabel)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}

class AlertsAndPopUps: NSObject {
    static let sharedInstance = AlertsAndPopUps()
    
    func showActivityViewController(objects: [AnyObject]) {
        let activityVC = UIActivityViewController.init(activityItems: objects, applicationActivities: nil)
        let excludeActivities = [UIActivity.ActivityType.assignToContact,
                                 UIActivity.ActivityType.postToFlickr,
                                 UIActivity.ActivityType.postToVimeo]
        
        activityVC.excludedActivityTypes = excludeActivities
        activityVC.completionWithItemsHandler = { (activity, success, items, error) in
            if activity != nil {
                if (activity?.rawValue.contains("CopyToPasteboard"))! {
                    if success {
                        Alert.sharedInstance.showSuccess(message: CommonLocalization.done.localized)
                    } else {
                        Alert.sharedInstance.showError(message: CommonLocalization.done.localized)
                    }
                }
            }
            print(success ? "SUCCESS!" : "FAILURE")
        }
    }
}

class MoreOptionConfig: NSObject {
    static let sharedInstance = MoreOptionConfig()
    
    func setupCustomPresetsForSharing(isExpired: Bool = false) -> EKAttributes {
        var attributes: EKAttributes
        // Preset I
        attributes = .bottomFloat
        attributes.displayMode = .light
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .init(light: UIColor(red: 0.06, green: 0.20, blue: 0.31, alpha: 0.5), dark: UIColor(red: 0.06, green: 0.20, blue: 0.31, alpha: 0.5)))
        attributes.entryBackground = .color(color: .white)
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = EKAttributes.UserInteraction.forward
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.entranceAnimation = .init(
            translate: .init(
                duration: 0.4,
                spring: .init(damping: 1, initialVelocity: 0)
            )
        )
        attributes.exitAnimation = .init(
            translate: .init(duration: 0.35)
        )
        attributes.popBehavior = .animated(
            animation: .init(
                translate: .init(duration: 0.35)
            )
        )
        attributes.shadow = .active(
            with: .init(
                color: .black,
                opacity: 0.3,
                radius: 6
            )
        )
        attributes.positionConstraints.size = .init(
            width: .fill,
            height: .ratio(value: isExpired ? 0.27 : 0.35)
        )
        attributes.positionConstraints.verticalOffset = 0
        attributes.positionConstraints.safeArea = .overridden
        attributes.statusBar = .dark
        
        return attributes
    }
}
