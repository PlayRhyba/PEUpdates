//
//  ServiceManager+Data.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-03.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension ServiceManager {
    
    @discardableResult func loadJobsSpreads(serverURL: URL?,
                                            success: SuccessBlock?,
                                            failure: FailureBlock?,
                                            progress: ProgressBlock?) -> URLSessionDataTask? {
        let parameters = [Constants.Keys.FromIPad: true]
        
        return sendGET(path: Constants.ServerPaths.JobsSpreadsData,
                       baseURL: serverURL,
                       parameters: parameters,
                       sessionManagerConfigurationBlock: nil,
                       success: { (response, data) in
                        ServiceResultsHandler.process(response: response,
                                                      data: data,
                                                      expectedResultType: .JSON_H,
                                                      success: success,
                                                      failure: failure)
        }, progress: progress, failure: failure)
    }
    
    
    @discardableResult func loadWeldData(spreadID: NSNumber,
                                         serverURL: URL?,
                                         success: SuccessBlock?,
                                         failure: FailureBlock?,
                                         progress: ProgressBlock?) -> URLSessionDataTask? {
        let parameters = [Constants.Keys.spreadId: spreadID,
                          Constants.Keys.From: Constants.Strings.iPad] as [String: Any]
        
        return sendPOST(path: Constants.ServerPaths.WeldData,
                        baseURL: serverURL,
                        parameters: parameters,
                        sessionManagerConfigurationBlock: nil,
                        success: { (response, data) in
                            ServiceResultsHandler.process(response: response,
                                                          data: data,
                                                          expectedResultType: .JSON,
                                                          success: success,
                                                          failure: failure)
        }, progress: progress, failure: failure)
    }
}
