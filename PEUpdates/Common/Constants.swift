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
        static let DataModelName = "PPEDB";
        static let LogsFolderName = "PPELogs"
    }
    
    
    struct Keys {
        static let Email = "email"
        static let Password = "password"
        static let From = "From"
        static let Json = "json"
    }
    
    
    struct ServerPaths {
        static let Login = "login.aspx"
        static let Profile = "profile.aspx"
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
