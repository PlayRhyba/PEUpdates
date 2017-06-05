//
//  RequestManager.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-06-05.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Alamofire


class RequestManager: NSObject {
    
    static let sharedInstance = RequestManager()
    private let sessionManager: SessionManager
    
    
    //MARK: Initialization
    
    
    private override init() {
        sessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    }
    
    
    //MARK: Public Methods
    
    
    @discardableResult
    func post<T>(path: String,
              baseURL: URL?,
              parameters: [String: Any]?,
              responseSerializer: DataResponseSerializer<T>,
              completionHandler: @escaping ((DataResponse<T>) -> Void)) -> DataRequest? {
        guard
            let url = baseURL?.appendingPathComponent(path)
            else {
                completionHandler(DataResponse(request: nil,
                                               response: nil,
                                               data: nil,
                                               result: Result.failure(Errors.internalError())))
                return nil
        }
        
        let queue = DispatchQueue.global()
        
        return sessionManager.request(url, method: .post, parameters: parameters)
            .validate()
            .response(queue: queue,
                      responseSerializer: responseSerializer,
                      completionHandler: { response in
                        
                        
                        //TODO: Possible additional logic
                        
                        
                        completionHandler(response)
            })
    }
    
    
    @discardableResult
    func get<T>(path: String,
             baseURL: URL?,
             parameters: [String: Any]?,
             responseSerializer: DataResponseSerializer<T>,
             completionHandler: @escaping ((DataResponse<T>) -> Void)) -> DataRequest? {
        guard
            let url = baseURL?.appendingPathComponent(path)
            else {
                completionHandler(DataResponse(request: nil,
                                               response: nil,
                                               data: nil,
                                               result: Result.failure(Errors.internalError())))
                return nil
        }
        
        let queue = DispatchQueue.global()
        
        return sessionManager.request(url, method: .get, parameters: parameters)
            .validate()
            .response(queue: queue,
                      responseSerializer: responseSerializer,
                      completionHandler: { response in
                        
                        
                        //TODO: Possible additional logic
                        
                        
                        completionHandler(response)
            })
    }
}
