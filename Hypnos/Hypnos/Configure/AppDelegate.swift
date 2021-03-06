//
//  AppDelegate.swift
//  Hypnos
//
//  Created by Maru on 16/4/9.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit

import AVFoundation
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = ContainerViewController()
        window?.makeKeyAndVisible()
        
        setupAppreance()
        
//        let session = AVAudioSession.sharedInstance()
//       
//        session.setCategory(AVAudioSessionCategoryPlayback)
//
//        session.setActive(true)

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    
    
    private func setupAppreance() {
        
        // SVProgressHUD的外观配置
        SVProgressHUD.setDefaultStyle(.Dark)
        SVProgressHUD.setDefaultMaskType(.Black)
        SVProgressHUD.setDefaultAnimationType(.Flat)
        
        // 导航栏的相关全局配置
        UINavigationBar.appearance().barTintColor = HypnosConfig.DefaultThemeColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: HypnosConfig.NavTextColor]
        UINavigationBar.appearance().tintColor = HypnosConfig.NavTextColor
        UINavigationBar.appearance().translucent = false
        
        // Tabbar的相关全局配置
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: HypnosConfig.TabbarTextColor_Normal], forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: HypnosConfig.DefaultThemeColor], forState: .Selected)
        
        UITabBar.appearance().translucent = false
    }
}

