//
//  PPEAuthorizationInfo.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-02.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class PPEAuthorizationInfo: NSObject {
    
    var serverVersion: String?
    var appAuthorizedForUser: Bool?
    var rolesAuthorizedForApp: String?
    var appVersionAuthorized: Bool?
    var isUserActive: Bool?
    
    
    init(withDictionary dictionary: Dictionary<String, Any>?) {
        if let d = dictionary {
            serverVersion = d["ServerVersion"] as? String
            appAuthorizedForUser = (d["AppAuthorizedForUser"] as? NSNumber)?.boolValue
            rolesAuthorizedForApp = d["RolesAuthorizedForApp"] as? String
            appVersionAuthorized = (d["AppVersionAuthorized"] as? NSNumber)?.boolValue
            isUserActive = (d["IsUserActive"] as? NSNumber)?.boolValue
        }
    }
    
    
    func isAuthorized() -> Bool {
        return appAuthorizedForUser != nil && appAuthorizedForUser! &&
            appVersionAuthorized != nil && appVersionAuthorized! &&
            isUserActive != nil && isUserActive!
    }
    
    
    func generateErrorMessage() -> String {
        var msg = "";
        
        if appAuthorizedForUser == nil || appAuthorizedForUser! == false {
            msg += "Your user role is unauthorized to use this App. Contact your administrator if you need access to this app. You must be added to one of these roles : "
            
            if let roles = rolesAuthorizedForApp {
                msg += roles
            }
        }
        
        if appVersionAuthorized == nil || appVersionAuthorized! == false {
            if msg.isEmpty == false {
                msg += "\n\n"
            }
            
            msg += "Your App Version is unauthorized to use this server. Download the latest version of the iPad client."
        }
        
        if isUserActive == nil || isUserActive! == false {
            if msg.isEmpty == false {
                msg += "\n\n"
            }
            
            msg += "Your User account is not active.  Contact your administrator if you need access to Pipeline Enterprise."
        }
        
        return msg
    }
}
