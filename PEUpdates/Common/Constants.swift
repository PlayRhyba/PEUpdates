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
        static let DateFormat = "dd-MMM-yyyy"
        static let ShortDateFormat = "MMM dd"
        static let DateTimeFormat = "dd-MMM-yyyy HH:mm:ss"
        static let SqlDateFormat = "yy-MM-dd"
        static let SqlDateTimeFormat = "yy-MM-dd HH:mm:ss"
        static let TimeFormat = "HH:mm:ss"
        static let TimeFormatHourMinutes = "HH:mm"
        
        
        static func date(fromString string: String) -> Date? {
            let formats = [self.DateFormat,
                           self.ShortDateFormat,
                           self.DateTimeFormat,
                           self.SqlDateFormat,
                           self.SqlDateTimeFormat,
                           self.TimeFormat,
                           self.TimeFormatHourMinutes]
            
            return string.date(withFormats: formats)
        }
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
