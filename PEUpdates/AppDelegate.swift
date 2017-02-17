//
//  AppDelegate.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/7/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit
import CocoaLumberjack
import SVProgressHUD


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    //MARK: Lifecycle Methods
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureLoggers()
        PPEDataStorage.sharedInstance.setup()
        
        return true
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        loadConfiguration()
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        PPEDataStorage.sharedInstance.cleanUp()
    }
    
    
    //MARK: Internal Logic
    
    
    private func configureLoggers() {
        #if DEBUG
            let defaultLogLevel: DDLogLevel = DDLogLevel.all
        #else
            let defaultLogLevel: DDLogLevel = DDLogLevel.warning
            
            let path = (Constants.LocalPaths.DocumentsDirectory as NSString).appendingPathComponent(Constants.Configuration.LogsFolderName)
            let logFileManager = DDLogFileManagerDefault.init(logsDirectory: path)
            logFileManager?.maximumNumberOfLogFiles = 10
            
            let fileLogger = DDFileLogger.init(logFileManager: logFileManager)
            fileLogger?.maximumFileSize = UInt64(3 * 1024 * 1024)
            fileLogger?.rollingFrequency = TimeInterval(60 * 60 * 24 * 7)
            
            DDLog.add(fileLogger, with: defaultLogLevel)
        #endif
        
        DDLog.add(DDTTYLogger.sharedInstance(), with: defaultLogLevel)
        DDLog.add(DDASLLogger.sharedInstance(), with: defaultLogLevel)
    }
    
    
    private func loadConfiguration() {
        let configurationManager = PPEConfigurationManager.sharedInstance
        
        if configurationManager.isLoaded() == false {
            SVProgressHUD.show(withStatus: "Configuration loading...")
            
            configurationManager.load { (_, error) in
                SVProgressHUD.dismiss()
                
                if let e = error {
                    SVProgressHUD.showError(withStatus: e.localizedDescription)
                }
            }
        }
    }
}
