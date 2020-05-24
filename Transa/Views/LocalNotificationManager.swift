//
//  LocalNotificationManager.swift
//  Transa
//
//  Created by Rizky Adipratama Ruddyar on 12/05/20.
//  Copyright © 2020 Rizky Adipratama Ruddyar. All rights reserved.
//

import Foundation
import UserNotifications

struct Notificatione {
    var id: String
    var title: String
}

class LocalNotificationManager {
    var notifications = [Notificatione]()
    
    func requestPermission() -> Void
    {
        UNUserNotificationCenter
        .current()
            .requestAuthorization(options: [.alert, .badge, .alert]) {granted, error in
                if granted == true && error == nil
                {
                    self.scheduleNotifications()
                    //permission accepted
                }
        }
        
    }
    
    func addNotification(title: String) -> Void
        {
            notifications.append(Notificatione(id: UUID().uuidString, title: title))
    }
    
    func scheduleNotifications() -> Void {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            
            
            var date1 = DateComponents()
            date1.hour = 20
            date1.minute = 00
            
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let trigger = UNCalendarNotificationTrigger(dateMatching: date1, repeats: true)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
                print("Scheduling notification with id: \(notification.id)")
            }
        }
    }
    
    func schedule() -> Void {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestPermission()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                break
            }
        }
    }
    
}

