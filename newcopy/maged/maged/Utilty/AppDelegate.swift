//  AppDelegate.swift
//  maged
//  Created by Ahmed Ashraf on 2/4/18.
//  Copyright © 2018 maged. All rights reserved.

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces
import IQKeyboardManagerSwift
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyDVF7awXGOs5X9D608l1BeES4UX7rHqsS4")
        GMSPlacesClient.provideAPIKey("AIzaSyDVF7awXGOs5X9D608l1BeES4UX7rHqsS4")
        setupIQKeyboardManagerAppearance()
        
        Localizer.localize()
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        if !UserDefaults.standard.bool(forKey: "isLoggedIn") {
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            window?.rootViewController = loginVC
            
        }else{
            window = UIWindow(frame: UIScreen.main.bounds)
            let initialViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
            let nav = UINavigationController(rootViewController: initialViewController!)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
        // Override point for customization after application launch.
        
        attemptRegisterForNotifications(application: application)
        
        return true
    }
    
    // setup appDelegate for push notification's
    private func attemptRegisterForNotifications(application: UIApplication){
        print("Attempting to register APNS...")
        
        UNUserNotificationCenter.current().delegate = self
        
        //user notifications auth
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
            
            if let error = error {
                print("Failed to  request auth", error.localizedDescription)
                return
            }
            
            if granted{
                print("Auth granted")
            }else {
                print("Auth denied")
            }
            
        }
        
        application.registerForRemoteNotifications()
        
    }
    
    
    // Method: 1 - will register app on apns to receive token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Registered for notifications Token :", token)
    }
    
    // Failed registration explain why
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for  remote notification : ", error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        print( "mmmmmmmmmmmmmmmmmmmmm", userInfo)
        
//        if let followerId = userInfo["followerId"] as? String {
//
//
//            // I want to push the UserProfileController for followerId somehow
//            let userProfileController = UserProfileCollectionVC(collectionViewLayout: UICollectionViewFlowLayout())
//            userProfileController.userId = followerId
//
//            // how do we access our main UI from AppDelegate
//            if let mainTabBarController = window?.rootViewController as? MainTabBarController {
//
//                mainTabBarController.selectedIndex = 0
//
//                mainTabBarController.presentedViewController?.dismiss(animated: true, completion: nil)
//
//                if let homeNavigationController = mainTabBarController.viewControllers?.first as? UINavigationController {
//                    homeNavigationController.pushViewController(userProfileController, animated: true)
//                }
//            }
//        }
    }
    
    func setupIQKeyboardManagerAppearance() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.toolbarTintColor = .black
        IQKeyboardManager.shared.shouldPlayInputClicks = true
    }
    
    
    func initWindow()  {
        
        if Language.currentLanguage == .arabic {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        //        setNavigationBarColor()
        UIApplication.shared.statusBarStyle = .lightContent
        
        setHomeAsRoot()
        //        if !Cache.isTutorialShown {
        //            self.setToturialAsRoot()
        //        } else if Cache.token == nil || ELUser.currentUser() == nil {
        //            Cache.clearToken()
        //            registerForRemoteNotification()
        //            //            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
        //            //                ACSammery.authorize()
        //            //            }
        //            setLoginAsRoot()
        //        } else {
        //            setHomeAsRoot()
        //        }
        
    }
    
    func setHomeAsRoot(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        let nav = UINavigationController(rootViewController: initialViewController!)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "maged")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

