//
//  SceneDelegate.swift
//  Insider-Case
//
//  Created by Ozgun Dogus on 16.03.2024.
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene:windowScene )
        window.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        window.rootViewController = navigationController
        
        self.window = window
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {          
           UNUserNotificationCenter.current().removeAllDeliveredNotifications()
       }

    func sceneDidEnterBackground(_ scene: UIScene) {
           
           saveStarsToUserDefaults()
           
           scheduleLocalNotification()
       }
    
    
    func saveStarsToUserDefaults() {
       }
    
    func scheduleLocalNotification() {
           let content = UNMutableNotificationContent()
           content.title = "Check the Stars"
           content.body = "Your sky might have more stars now. Check it out!"
           content.sound = .default

           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
           let request = UNNotificationRequest(identifier: "starNotification", content: content, trigger: trigger)

           UNUserNotificationCenter.current().add(request) { error in
               if let error = error {
                   print("Error scheduling notification: \(error)")
               }
           }
       }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

}

extension SceneDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .sound])
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "starNotification" {
            NotificationCenter.default.post(name: NSNotification.Name("ResetStars"), object: nil)
        }
        completionHandler()
    }
}
