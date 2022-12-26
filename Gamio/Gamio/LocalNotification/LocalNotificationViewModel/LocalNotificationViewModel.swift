//
//  LocalNotificationViewModel.swift
//  Gamio
//
//  Created by Gokberk Ozcan on 17.12.2022.
//
import Foundation
protocol LocalNotificationViewModelProtocol {
    func setNotification() -> Bool
    func removeNotification() -> Bool
}


final class LocalNotificationViewModel: LocalNotificationViewModelProtocol {
    
    @discardableResult
    func setNotification() -> Bool {
        LocalNotificationManager.setNotification(5, of: .seconds, repeats: false, title: "Gamio", body: "notificationText".localized, userInfo: ["aps" : ["hello" : "world"]])
        return true
    }
    
    @discardableResult
    func removeNotification() -> Bool {
        LocalNotificationManager.cancel()
        return true
    }    
}

