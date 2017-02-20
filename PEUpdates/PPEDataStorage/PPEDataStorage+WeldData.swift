//
//  PPEDataStorage+WeldData.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-20.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import MagicalRecord


extension (PPEDataStorage) {
    
    
    func welds(spreadID: NSNumber) -> [PPEWeld]? {
        return PPEWeld.mr_findAll(with: NSPredicate.predicate(spreadID: spreadID)) as? [PPEWeld]
    }
    
    
    func saveWeldData(withDictionary dictionary: [String: Any]?,
                      spreadID: NSNumber,
                      completion:((Bool, Error?) -> Void)?) {
        MagicalRecord.save({ (localContext) in
            self.saveWelds(withDictionary: dictionary, spreadID: spreadID, localContext: localContext)
            
            
            //TODO: Handle other models
            
            
        }, completion: completion)
    }
    
    
    //MARK: Internal Logic
    
    
    private func saveWelds(withDictionary dictionary: [String: Any]?,
                           spreadID: NSNumber,
                           localContext: NSManagedObjectContext) {
        if let weldsData = dictionary?[Constants.Tables.Weld] {
            if weldsData is Array<Dictionary<String, Any>> {
                PPEWeld.mr_deleteAll(matching: NSPredicate.predicate(spreadID: spreadID), in: localContext)
                
                for data in (weldsData as! Array<Dictionary<String, Any>>) {
                    let weld = PPEWeld.mr_createEntity(in: localContext)
                    weld?.fill(withDictionary: data)
                }
            }
        }
    }
}
