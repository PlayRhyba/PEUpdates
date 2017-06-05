//
//  RequestManager+Authorization.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-06-05.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Alamofire


extension RequestManager {
    
    @discardableResult
    func login(email: String,
               password: String,
               serverURL: URL?,
               completionHandler: @escaping ((DataResponse<String>) -> Void)) -> DataRequest? {
        let parameters = [Constants.Keys.Email: email,
                          Constants.Keys.Password: password,
                          Constants.Keys.From: Constants.Strings.iPad]
        
        return post(path: Constants.ServerPaths.Login,
                    baseURL: serverURL,
                    parameters: parameters,
                    responseSerializer: DataRequest.stringResponseSerializer(),
                    completionHandler: completionHandler)
    }
    
    
    @discardableResult
    func authorize(version: String,
                   build: String,
                   serverURL: URL?,
                   completionHandler: @escaping ((DataResponse<Any>) -> Void)) -> DataRequest? {
        let parameters = [Constants.Keys.From: Constants.Strings.iPad,
                          Constants.Keys.Version: version,
                          Constants.Keys.Build: build]
        
        return post(path: Constants.ServerPaths.Authorize,
                    baseURL: serverURL,
                    parameters: parameters,
                    responseSerializer: DataRequest.jsonResponseSerializer(),
                    completionHandler: completionHandler)
    }
}
