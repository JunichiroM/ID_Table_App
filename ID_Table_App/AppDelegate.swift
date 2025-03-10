//
//  AppDelegate.swift
//  ID_Table_App
//
//  Created by apple on 2025/03/05.
//

//import Foundation
import BackgroundTasks
import UIKit

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BackgroundTaskManager.shared.sendJsonFile()  // ✅ Call function directly
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //BackgroundTaskManager.shared.scheduleSendJsonTask()
        print("🔄 App moved to the background")
        
        // Schedule background task
        //BackgroundTaskManager.shared.scheduleSendJsonTask()
        
    }
}
