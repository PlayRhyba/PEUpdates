//
//  DataStorage+Profile.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-01.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import MagicalRecord


extension DataStorage {
    
    func profile() -> Profile? {
        return Profile.mr_findAll()?.first as? Profile
    }
    
    
    func updateProfile(withDictionary dictionary: [String: Any]?,
                       completion: SaveCompletionBlock?) {
        MagicalRecord.save({ (localContext) in
            if let p = self.profile() {
                p.fill(withDictionary: dictionary)
            }
            else {
                let profile = Profile.mr_createEntity(in: localContext)
                profile?.fill(withDictionary: dictionary)
            }
        }, completion: completion)
    }
}
