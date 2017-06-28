//
//  Errors.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


struct Errors {
    
    enum Domains: String {
        case `internal` = "InternalErrorDomain"
        case responseObject = "ResponseObjectErrorDomain"
        case login = "LoginErrorDomain"
        case configurationManager = "ConfigurationManagerErrorDomain"
    }
    
    
    enum Codes: Int {
        case `internal` = 5000
        case responseObject
        case operationCanceled
        case login
        case authorization
        case configurationDataFormat
    }
    
    
    static func internalError() -> NSError {
        return NSError(domain: Domains.internal.rawValue,
                       code: Codes.internal.rawValue,
                       userInfo:[NSLocalizedDescriptionKey: "Internal Error"])
    }
    
    
    static func unexpectedResponseDataStructureError() -> NSError {
        return NSError(domain: Domains.responseObject.rawValue,
                       code: Codes.responseObject.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: "Unexpected response data structure"])
    }
    
    
    static func operationCanceledError() -> NSError {
        return NSError(domain: Domains.internal.rawValue,
                       code: Codes.operationCanceled.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: "Operation canceled"])
    }
    
    
    static func loginError(string: String?) -> NSError {
        let description = string ?? "Login error"
        
        return NSError(domain: Domains.login.rawValue,
                       code: Codes.login.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    
    static func authorizationError(authInfo: AuthorizationInfo) -> NSError {
        var msg = ""
        
        func append(_ string: String) {
            if msg.isEmpty == false {
                msg += "\n\n"
            }
        }
        
        if authInfo.appAuthorizedForUser == nil || authInfo.appAuthorizedForUser! == false {
            append("Your user role is unauthorized to use this App. Contact your administrator if you need access to this app. You must be added to one of these roles : ")
            
            if let roles = authInfo.rolesAuthorizedForApp {
                msg += roles
            }
        }
        
        if authInfo.appVersionAuthorized == nil || authInfo.appVersionAuthorized! == false {
            append("Your App Version is unauthorized to use this server. Download the latest version of the iPad client.")
        }
        
        if authInfo.isUserActive == nil || authInfo.isUserActive! == false {
            append("Your User account is not active. Contact your administrator if you need access to Pipeline Enterprise.")
        }
        
        return NSError(domain: Domains.login.rawValue,
                       code: Codes.authorization.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: msg])
    }
    
    
    static func spreadsDataUnavailableError() -> NSError {
        return NSError(domain: Domains.responseObject.rawValue,
                       code:Codes.responseObject.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: "Spreads data is unavailable"])
    }
    
    
    static func configurationDataFormatError() -> NSError {
        return NSError(domain: Domains.configurationManager.rawValue,
                       code: Codes.configurationDataFormat.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: "Configuration data format error"])
    }
}
