//
//  AppDelegate.swift
//  POS
//
//  Created by Djubo on 28/06/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import UIKit
import Material
import DropDown

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var leftMenuViewController : SliderMenuLeftVC?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DropDown.startListeningToKeyboard()

        return true
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
    
    func showHomeScreen(){
        window = UIWindow()
        window?.makeKeyAndVisible()
        let storyboard = UIStoryboard(name: "POSMain", bundle: nil)
       let containerVC = storyboard.instantiateViewController(withIdentifier: "ContainerController") as? ContainerController
        window?.rootViewController = containerVC
    
        
    }
    
    func navigateToViewController(viewController : UIViewController,self1: UIViewController){
        let nvc: NavigationController = NavigationController(rootViewController: AppToolbarController(rootViewController:viewController))
        
        leftMenuViewController?.mainViewController = nvc
        
        
        let slideMenuController = NavigationDrawerController.init(rootViewController: nvc, leftViewController: self1, rightViewController: nil)
        
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
        
    }


}

