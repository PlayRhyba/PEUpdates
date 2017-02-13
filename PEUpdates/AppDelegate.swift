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
        self.configureLoggers()
        PPEDataStorage.sharedInstance.setup()
        self.loadConfiguration()
        
        return true
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        PPEDataStorage.sharedInstance.cleanUp();
    }
    
    
    //MARK: Internal Logic
    
    
    private func configureLoggers() {
        #if DEBUG
            let defaultLogLevel: DDLogLevel = DDLogLevel.all
        #else
            let defaultLogLevel: DDLogLevel = DDLogLevel.debug
            
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
        SVProgressHUD.show(withStatus: "Configuration loading...")
        
        PPEConfigurationManager.sharedInstance.load { (error) in
            if let e = error {
                SVProgressHUD.showError(withStatus: e.localizedDescription)
            }
            else {
                SVProgressHUD.dismiss()
            }
        }
    }
}

