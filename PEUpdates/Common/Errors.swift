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
        case InternalErrorDomain = "InternalErrorDomain"
        case ResponseObjectErrorDomain = "ResponseObjectErrorDomain"
        case LoginErrorDomain = "LoginErrorDomain"
    }
    
    
    enum Codes: Int {
        case InternalErrorCode = 5000
        case ResponseObjectErrorCode
        case OperationCanceledErrorCode
        case LoginErrorCode
        case AuthorizationErrorCode
    }
    
    
    struct Constants {
        static let NotCompletedOperationErrorCode = -999;
    }
    
    
    static func internalError() -> Error {
        return NSError(domain: Domains.InternalErrorDomain.rawValue,
                       code: Codes.InternalErrorCode.rawValue,
                       userInfo:[NSLocalizedDescriptionKey: "Internal Error"])
    }
    
    
    static func unexpectedResponseDataStructureError() -> Error {
        return NSError(domain: Domains.ResponseObjectErrorDomain.rawValue,
                       code: Codes.ResponseObjectErrorCode.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: "Unexpected response data structure"])
    }
    
    
    static func operationCanceledError() -> Error {
        return NSError(domain: Domains.InternalErrorDomain.rawValue,
                       code: Codes.OperationCanceledErrorCode.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: "Operation canceled"])
    }
    
    
    static func loginError(string: String?) -> Error {
        let description = string ?? "Login error"
        
        return NSError(domain: Domains.LoginErrorDomain.rawValue,
                       code: Codes.LoginErrorCode.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    
    static func authorizationError(authInfo: PPEAuthorizationInfo) -> Error {
        var msg = "";
        
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
        
        return NSError(domain: Domains.LoginErrorDomain.rawValue,
                       code: Codes.AuthorizationErrorCode.rawValue,
                       userInfo: [NSLocalizedDescriptionKey: msg])
    }
}
