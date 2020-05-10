//
//  UserNotif.swift
//
//  Created by keyle on 10/5/20.
//
//  Based on https://cocoacasts.com/local-notifications-with-the-user-notifications-framework/
//
//  UserNotif.makeNotification(...)

import UserNotifications

public class UserNotif {
        
    public static func makeNotification(title: String, body: String, subtitle: String?) {
        
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            
            switch notificationSettings.authorizationStatus {
                
            case .notDetermined: // Request Authorization
                UserNotif.requestAuthorization(completionHandler: { (success) in
                    guard success else {
                        print("Application was denied Notifications access")
                        return }
                    UserNotif.scheduleLocalNotification(title: title, body: body, subtitle: subtitle)
                })
                
            case .authorized:
                UserNotif.scheduleLocalNotification(title: title, body: body, subtitle: subtitle)
                
            case .denied:
                print("Application Not Allowed to Display Notifications")
                
            default:
                print("Unknown authorization status")
            }
        }
    }
    
    private static func scheduleLocalNotification(title: String, body: String, subtitle: String?) {
        
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = title
        notificationContent.subtitle = subtitle ?? ""
        notificationContent.body = body
        
        if let url = Bundle.main.urlForImageResource("StatusBarButtonImage") {
            if let attachment = try? UNNotificationAttachment(identifier: "dune",
                                                              url: url,
                                                              options: nil) {
                notificationContent.attachments = [attachment]
            }
        }

        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.05, repeats: false)
        
        let notificationRequest = UNNotificationRequest(identifier: NSUUID().uuidString, content: notificationContent, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    
    private static func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            completionHandler(success)
        }
    }
    
}
