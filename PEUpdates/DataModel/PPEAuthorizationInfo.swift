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
}
