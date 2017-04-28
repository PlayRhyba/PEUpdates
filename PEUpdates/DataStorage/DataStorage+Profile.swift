//
//  DataStorage+Profile.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-01.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


extension DataStorage {
    
    func profile() -> Profile? {
        return Profile.performFetch(withRequestConfiguration: nil,
                                    inContext: persistentContainer.viewContext)?.first as? Profile
    }
    
    
    func updateProfile(withDictionary dictionary: [String: Any]?,
                       completion: OperationCompletionBlock?) {
        persistentContainer.performBackgroundTask { (context) in
            if let p = self.profile() {
                p.fill(withDictionary: dictionary)
            }
            else {
                let profile = Profile(context: context)
                profile.fill(withDictionary: dictionary)
            }
            
            do {
                try context.save()
                completion?(true, nil)
            }
            catch {
                completion?(false, error)
            }
        }
    }
}
