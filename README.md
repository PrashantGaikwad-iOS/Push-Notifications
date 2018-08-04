# Push-Notifications

 
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
