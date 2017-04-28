//
//  ServiceGateway+Login.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/8/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension ServiceGateway {
    
    @discardableResult class func login(email: String,
                                        password: String,
                                        serverURL: URL?,
                                        success: ServiceManager.SuccessBlock?,
                                        failure: ServiceManager.FailureBlock?) -> URLSessionDataTask? {
        return ServiceManager.sharedInstance.login(email: email,
                                                   password: password,
                                                   serverURL: serverURL,
                                                   success: { (response, data) in
                                                    let dataString = data as! String
                                                    
                                                    if dataString == Constants.Strings.LoggedIn {
                                                        success?(response, dataString)
                                                    }
                                                    else {
                                                        failure?(response, Errors.loginError(string: dataString))
                                                    }
        }, failure: failure)
    }
    
    
    class func authenticate(email: String,
                            password: String,
                            server: String,
                            success: ((Profile) -> Void)?,
                            failure: ServiceManager.FailureBlock?) {
        let invokeSuccess: (Profile) -> Void = { (profile) in
            if let block = success {
                DispatchQueue.main.async {
                    block(profile)
                }
            }
        }
        
        let invokeFailure: ServiceManager.FailureBlock = { (response, error) in
            if let block = failure {
                DispatchQueue.main.async {
                    block(response, error)
                }
            }
        }
        
        let url = URL(string: server)
        
        login(email: email, password: password, serverURL: url, success: { (_, _) in
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
            let build = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as! String
            
            let serviceManager = ServiceManager.sharedInstance
            let dataStorage = DataStorage.sharedInstance
            
            serviceManager.authorize(version: version, build: build, serverURL: url, success: { (response, data) in
                let authInfo = AuthorizationInfo.init(withDictionary: data as? [String: Any])
                
                if authInfo.isAuthorized() {
                    serviceManager.loadProfile(serverURL: url, success: { (response, data) in
                        dataStorage.updateProfile(withDictionary: data as? Dictionary,
                                                  completion: { (success, error) in
                                                    if success {
                                                        if let profile = dataStorage.profile() {
                                                            invokeSuccess(profile)
                                                        }
                                                        else {
                                                            invokeFailure(nil, Errors.internalError())
                                                        }
                                                    }
                                                    else {
                                                        invokeFailure(nil, error!)
                                                    }
                        })
                    }, failure: invokeFailure)
                }
                else {
                    invokeFailure(response, Errors.authorizationError(authInfo: authInfo))
                }
            }, failure: invokeFailure)
        }, failure: invokeFailure)
    }
}
