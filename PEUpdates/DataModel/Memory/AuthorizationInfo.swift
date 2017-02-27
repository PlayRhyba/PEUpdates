//
//  AuthorizationInfo.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-02.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class AuthorizationInfo: BaseMemoryDataModel {
    
    var serverVersion: String?
    var appAuthorizedForUser: Bool?
    var rolesAuthorizedForApp: String?
    var appVersionAuthorized: Bool?
    var isUserActive: Bool?
    
    
    //MARK: BaseMemoryDataModel
    
    
    override init(withDictionary dictionary: [String: Any]?) {
        super.init(withDictionary: dictionary)
        
        serverVersion = dictionary?["ServerVersion"] as? String
        appAuthorizedForUser = (dictionary?["AppAuthorizedForUser"] as? NSNumber)?.boolValue
        rolesAuthorizedForApp = dictionary?["RolesAuthorizedForApp"] as? String
        appVersionAuthorized = (dictionary?["AppVersionAuthorized"] as? NSNumber)?.boolValue
        isUserActive = (dictionary?["IsUserActive"] as? NSNumber)?.boolValue
    }
    
    
    //MARK: Public Methods
    
    
    func isAuthorized() -> Bool {
        return appAuthorizedForUser != nil && appAuthorizedForUser! &&
            appVersionAuthorized != nil && appVersionAuthorized! &&
            isUserActive != nil && isUserActive!
    }
}
