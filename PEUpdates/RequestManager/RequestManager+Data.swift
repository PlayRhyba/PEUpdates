//
//  RequestManager+Data.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-06-05.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Alamofire


extension RequestManager {
    
    @discardableResult
    func loadJobsSpreads(serverURL: URL?,
                         completionHandler: @escaping ((DataResponse<Any>) -> Void)) -> DataRequest? {
        let parameters = [Constants.Keys.FromIPad: true]
        
        return get(path: Constants.ServerPaths.JobsSpreadsData,
                   baseURL: serverURL,
                   parameters: parameters,
                   responseSerializer: DataRequest.hartleysJsonResponseSerializer(),
                   completionHandler: completionHandler)
    }
    
    
    @discardableResult
    func loadWeldData(spreadID: NSNumber,
                      serverURL: URL,
                      completionHandler: @escaping ((DataResponse<Any>) -> Void)) -> DataRequest? {
        let parameters = [Constants.Keys.spreadId: spreadID,
                          Constants.Keys.From: Constants.Strings.iPad] as [String: Any]
        
        return post(path: Constants.ServerPaths.WeldData,
                    baseURL: serverURL,
                    parameters: parameters,
                    responseSerializer: DataRequest.jsonResponseSerializer(),
                    completionHandler: completionHandler)
    }
}
