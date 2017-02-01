//
//  AppDelegate.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/7/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit
import CocoaLumberjack


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    //MARK: Lifecycle Methods


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        PPEDataStorage.sharedInstance.setup()
        return true
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        PPEDataStorage.sharedInstance.cleanUp();
    }
    
    
    //MARK: Internal Logic
    
    
    private func configureLoggers() {
        DDLog.add(DDTTYLogger.sharedInstance())
        DDLog.add(DDASLLogger.sharedInstance())
        
        let path = Constants.LocalPaths.DocumentsDirectory //appending(Constants.Configuration.LogsFolderName)
        
        
        //TODO: Configure file logger
        
        
    }
}

