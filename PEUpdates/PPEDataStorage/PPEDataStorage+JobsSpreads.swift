//
//  PPEDataStorage+Data.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-16.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import MagicalRecord


extension (PPEDataStorage) {
    
    func spreads() -> [PPESpread]? {
        return PPESpread.mr_findAll() as? [PPESpread]
    }
    
    
    func saveJobsSpreadsData(withDictionary dictionary: [String: Any]?,
                             completion: SaveCompletionBlock?) {
        MagicalRecord.save({ (localContext) in
            self.saveSpreads(withDictionary: dictionary, localContext: localContext)
            self.saveLabourSpreads(withDictionary: dictionary, localContext: localContext)
            
            
            //TODO: Handle other data models
            
            
        }, completion: completion)
    }
    
    
    //MARK: Internal Logic
    
    
    private func saveSpreads(withDictionary dictionary: [String: Any]?,
                             localContext: NSManagedObjectContext) {
        if let spreadsData = dictionary?[Constants.Tables.Spread] {
            if spreadsData is [[String: Any]] {
                PPESpread.mr_truncateAll(in: localContext)
                
                for data in spreadsData as! [[String: Any]] {
                    let spread = PPESpread.mr_createEntity(in: localContext)
                    spread?.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func saveLabourSpreads(withDictionary dictionary: [String: Any]?,
                                   localContext: NSManagedObjectContext) {
        if let labourSpreadsData = dictionary?[Constants.Tables.LabourSpread] {
            if labourSpreadsData is [[String: Any]] {
                PPELabourSpread.mr_truncateAll(in: localContext)
                
                for data in labourSpreadsData as! [[String: Any]] {
                    let labourSpread = PPELabourSpread.mr_createEntity(in: localContext)
                    labourSpread?.fill(withDictionary: data)
                }
            }
        }
    }
}
