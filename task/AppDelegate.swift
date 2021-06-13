//
//  AppDelegate.swift
//  task
//
//  Created by 布川のぞみ on 2021/02/07.
//

import UIKit
import RealmSwift
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //通知許可の取得
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(granted: Bool, error: Error?) in
            print("許可されたか: \(granted)")
            UNUserNotificationCenter.current().delegate = self
        }
        UNUserNotificationCenter.current().delegate = self
        return true
        
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
            return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        }
        //通知を受け取った際に呼ばれるメソッド
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
               completionHandler(
                   [
                       UNNotificationPresentationOptions.banner,
                       UNNotificationPresentationOptions.list,
                       UNNotificationPresentationOptions.sound,
                       UNNotificationPresentationOptions.badge
                   ]
               )
           }
           // バックグランドで通知を受け取った際に呼ばれるメソッド
           func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
               completionHandler()
           }
        // Override point for customization after application launch.
        let config = Realm.Configuration(
         schemaVersion: 1, migrationBlock: nil, deleteRealmIfMigrationNeeded: true)
        
        Realm.Configuration.defaultConfiguration = config
        return true
    }
    // MARK: UISceneSession Lifecycle
}
