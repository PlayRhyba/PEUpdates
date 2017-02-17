//
//  Constants.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


struct Constants {
    
    struct Configuration {
        static let DataModelName = "PPEDB"
        static let LogsFolderName = "PPELogs"
    }
    
    
    struct Tables {
        static let Profile = "Profile"
        static let Spread = "Spread"
        static let LabourSpread = "LabourSpread"
    }
    
    
    struct Keys {
        static let Email = "email"
        static let Password = "password"
        static let From = "From"
        static let Json = "json"
        static let Version = "Version"
        static let Build = "Build"
        static let FromIPad = "FromiPad"
    }
    
    
    struct ServerPaths {
        static let Login = "login.aspx"
        static let Authorize = "authorize.aspx"
        static let Profile = "profile.aspx"
        static let JobsSpreadsData = "JobSpreadData.aspx"
    }
    
    
    struct DateFormats {
        
        
        //TODO: Describe date formates
        
        
//        #define DATE_FORMAT @"dd-MMM-yyyy"
//        #define DATE_SHORT_FORMAT @"MMM dd"
//        #define DATE_TIME_FORMAT @"dd-MMM-yyyy HH:mm:ss"
//        #define SQL_DATE_FORMAT @"yy-MM-dd"
//        #define SQL_DATE_TIME_FORMAT @"yy-MM-dd HH:mm:ss"
//        #define TIME_FORMAT @"HH:mm:ss"
//        #define TIME_FORMAT_HOURS_MINUTES @"HH:mm"
    }
    
    
    struct LocalPaths {
        static var DocumentsDirectory: String {
            return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        }
    }
    
    
    struct Strings {
        static let LoggedIn = "LoggedIn"
        static let iPad = "iPad"
    }
}
