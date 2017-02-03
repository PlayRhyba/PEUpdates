//
//  PPEServiceManager+Data.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-03.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


extension PPEServiceManager {
    
    @discardableResult func loadJobsSpreads(serverURL: URL?,
                                            success: SuccessBlock?,
                                            failure: FailureBlock?,
                                            progress: ProgressBlock?) -> URLSessionDataTask? {
        let parameters = [Constants.Keys.FromIPad: true]
        
        return self.sendGET(path: Constants.ServerPaths.JobsSpreadsData,
                            baseURL: serverURL,
                            parameters: parameters,
                            sessionManagerConfigurationBlock: nil,
                            success: { (response, data) in
                                PPEServiceResultsHandler.process(response: response,
                                                                 data: data,
                                                                 expectedResultType: .JSON,
                                                                 success: success,
                                                                 failure: failure)
        }, progress: progress, failure: failure)
    }
}
