//
//  RequestManager+Profile.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-06-05.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Alamofire


extension RequestManager {
    @discardableResult
    func loadProfile(serverURL: URL?,
                     completionHandler: @escaping ((DataResponse<Any>) -> Void)) -> DataRequest? {
        return get(path: Constants.ServerPaths.Profile,
                   baseURL: serverURL,
                   parameters: nil,
                   responseSerializer: DataRequest.jsonResponseSerializer(),
                   completionHandler: completionHandler)
    }
}
