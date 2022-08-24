//
//  MainViewController.swift
//  BackgroundPushes
//
//  Created by Jaewon on 2022/08/17.
//

import UIKit
import OSLog

final class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapRegisterNotificationButton(_ sender: UIButton) {
        let notification = UNMutableNotificationContent.init()
        notification.title = "Title"
        notification.subtitle = "subtitle"
        notification.body = "body"
        notification.sound = .default
        notification.userInfo = ["createdTime" : Date.init()]
        
        let timeInterval: TimeInterval = 5.0
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: timeInterval, repeats: false)
        
        let identifier = "LocalNotification"
        let request = UNNotificationRequest.init(
            identifier: identifier,
            content: notification,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
        Logger.pushNotification.notice("알림 등록 완료(\(timeInterval, format: .hybrid)초 후 알림, Identifier: \(identifier))")
    }
}
