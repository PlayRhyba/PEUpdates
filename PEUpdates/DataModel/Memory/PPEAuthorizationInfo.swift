//
//  PPEAuthorizationInfo.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-02.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class PPEAuthorizationInfo: PPEBaseMemoryDataModel {
    
    var serverVersion: String?
    var appAuthorizedForUser: Bool?
    var rolesAuthorizedForApp: String?
    var appVersionAuthorized: Bool?
    var isUserActive: Bool?
    
    
    override init(withDictionary dictionary: [String: Any]?) {
        super.init(withDictionary: dictionary)
        
        serverVersion = dictionary?["ServerVersion"] as? String
        appAuthorizedForUser = (dictionary?["AppAuthorizedForUser"] as? NSNumber)?.boolValue
        rolesAuthorizedForApp = dictionary?["RolesAuthorizedForApp"] as? String
        appVersionAuthorized = (dictionary?["AppVersionAuthorized"] as? NSNumber)?.boolValue
        isUserActive = (dictionary?["IsUserActive"] as? NSNumber)?.boolValue
    }
    
    
    func isAuthorized() -> Bool {
        return appAuthorizedForUser != nil && appAuthorizedForUser! &&
            appVersionAuthorized != nil && appVersionAuthorized! &&
            isUserActive != nil && isUserActive!
    }
}
