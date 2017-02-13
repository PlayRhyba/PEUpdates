//
//  PPEConfigurationManager.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-13.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class PPEConfigurationManager: NSObject {
    
    static let sharedInstance = PPEConfigurationManager()
    private lazy var fields = [String: PPEFieldDescription]()
    
    
    //MARK: NSObject
    
    
    private override init() {}
    
    
    //MARK: Public Methods
    
    
    func load(withCompletion completion: ((Error?) -> Void)?) {
        let invokeCompletion: (Error?) -> Void = { (error) in
            DispatchQueue.main.async {
                if let block = completion {
                    block(error)
                }
            }
        }
        
        DispatchQueue.global().async {
            let fieldsFolderPath = Bundle.main.resourcePath?.appending("/Configuration/Fields")
            
            do {
                let fieldsFilePaths = try FileManager.default.contentsOfDirectory(atPath: fieldsFolderPath!)
                
                for path in fieldsFilePaths {
                    
                    
                    //TODO: Parse json files, load to cache dictionary
                    
                    
                }
            }
            catch {
                invokeCompletion(error)
            }
        }
    }
    
    
    func clear() {
        
        
        //TODO: Clear db and memory cache
        
        
    }
}
