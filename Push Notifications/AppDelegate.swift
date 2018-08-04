//
//  AppDelegate.swift
//  Push Notifications
//
//  Created by Prashant G on 8/4/18.
//  Copyright © 2018 MyOrg. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register for remote notifications with with error: \(error)")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("granted: (\(granted)")
        }
        
        UIApplication.shared.registerForRemoteNotifications() //(I)

        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("handling notification")
        if let notification = response.notification.request.content.userInfo as? [String:AnyObject] {
            let message = parseRemoteNotification(notification: notification)
            print(message as Any)
        }
        completionHandler()
    }
    
    private func parseRemoteNotification(notification:[String:AnyObject]) -> String? {
        if let aps = notification["aps"] as? [String:AnyObject] {
            let alert = aps["alert"] as? String
            return alert
        }
        
        if let identifier = notification["identifier"] as? String {
            return identifier
        }
        
        return nil
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

/*
 Push Notifications
 
 App
 1. Request to get register for PN
 5. Sends device token to the backend
 
 Device
 2. Hands request to APNS
 4. Hands token over to the app
 
 Backend
 6. Backend sends a notification and device token to the APNS
 
 APNS
 3. Sends device token
 7. APNS sends notification to the device
 
 
 
 Setup
 
 Capabilities -
 PushNotifications - turn ON
 
 AppDelegate:
 
 UIApplication.shared.registerForPushNotification()
 
 didregisterForRemoteNotification - get the token :
 Let token = deviceToken.map { String(format: “%02.2hhx”, $0) }.joined()
 
 didFailToRegister
 
 Goto apple account
 Create certificates -
 Open keychain
 Create CertificateSigningRequest.certSigningRequest and add it and download, it will show in keychain
 
 
 Handling:
 func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
 
 private func parseRemoteNotification(notification:[String:AnyObject]) -> String? {
 

 Payload body for Pusher - {"aps":{"alert":"Testing.. (30)","badge":1,"sound":"default"}}
 
 
 */

