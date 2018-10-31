//
//  AppDelegate.swift
//  MRK24
//
//  Created by LOKESH  yadav on 10/18/18.
//  Copyright © 2018 LOKESH  yadav. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     FirebaseApp.configure()
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        setupLoginCredential()
        // Override point for customization after application launch.
        return true
    }

    func setupLoginCredential() {
        if let userData = UserDefaults.standard.value(forKey: kCurrentUser) as? Data{
            if let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? CurrentUser{
                APIHandler.sharedInstance.currentUser = user
                temp()
                findEnterPoint()
                
            }
        }
    }
    func temp() {
        CurrentUser.sharedInstance.id =  APIHandler.sharedInstance.currentUser.id
        CurrentUser.sharedInstance.first_name =  APIHandler.sharedInstance.currentUser.first_name
        CurrentUser.sharedInstance.last_name =  APIHandler.sharedInstance.currentUser.last_name
        CurrentUser.sharedInstance.username =  APIHandler.sharedInstance.currentUser.username
        CurrentUser.sharedInstance.email_id = APIHandler.sharedInstance.currentUser.email_id
        CurrentUser.sharedInstance.phone_number =  APIHandler.sharedInstance.currentUser.phone_number
        CurrentUser.sharedInstance.address =  APIHandler.sharedInstance.currentUser.address
        CurrentUser.sharedInstance.city =  APIHandler.sharedInstance.currentUser.city
        CurrentUser.sharedInstance.state =  APIHandler.sharedInstance.currentUser.state
        CurrentUser.sharedInstance.country =  APIHandler.sharedInstance.currentUser.country
        CurrentUser.sharedInstance.profileImage =  APIHandler.sharedInstance.currentUser.profileImage
        
    }
    
    private func findEnterPoint() {
        let mainStoryBoard = UIStoryboard(name: "SideMenu", bundle: Bundle.main)
       window?.rootViewController = mainStoryBoard.instantiateViewController(withIdentifier: "ECSlidingViewController")
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
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        debugPrint("T##items: Any...##Any")
        
    }
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        debugPrint("")
    }
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        debugPrint("success")
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let varAvgvalue = String(format: "%@", deviceToken as CVarArg)
        
        let  token = varAvgvalue.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).replacingOccurrences(of: " ", with: "")
        
        print(token)
        Messaging.messaging().apnsToken = deviceToken
    }

    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}

