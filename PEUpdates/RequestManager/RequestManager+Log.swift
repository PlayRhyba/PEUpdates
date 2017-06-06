//
//  RequestManager+Log.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-06-06.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Alamofire
import CocoaLumberjack


extension DataRequest {
    
    @discardableResult
    func log() -> Self {
        DDLogInfo("\(description)")
        DDLogDebug("\(debugDescription)")
        return self
    }
}


extension DataResponse {
    
    func log() {
        if result.isSuccess {
            DDLogInfo("\(result.description)")
            DDLogDebug("\(debugDescription)")
        }
        else {
            DDLogError(debugDescription)
        }
    }
}
