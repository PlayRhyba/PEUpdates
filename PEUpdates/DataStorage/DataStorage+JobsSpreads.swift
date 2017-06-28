//
//  DataStorage+Data.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-16.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData
import CocoaLumberjack


extension DataStorage {
    
    func spreads() -> [Spread]? {
        return Spread.performFetch(requestConfiguration: nil,
                                   inContext: persistentContainer.viewContext) as? [Spread]
    }
    
    
    func populateJobsSpreadsData(withDictionary dictionary: [String: Any]?,
                                 completionHandler: ((OperationResult<Void>) -> Void)?) {
        if let dictionary = dictionary {
            persistentContainer.performBackgroundTask { [unowned self] context in
                self.clearJobsSpreadsData(inContext: context)
                
                self.populateSpreads(withDictionary: dictionary, inContext: context)
                self.populateLabourSpreads(withDictionary: dictionary, inContext: context)
                
                do {
                    try context.save()
                    completionHandler?(OperationResult.success())
                }
                catch {
                    completionHandler?(OperationResult.failure(error))
                }
            }
        }
    }
    
    
    func clearJobsSpreadsData(inContext context: NSManagedObjectContext) {
        Spread.deleteAll(inContext: context)
        LabourSpread.deleteAll(inContext: context)
        
        
        //TODO: Clear other models
        
        
    }
    
    
    //MARK: Internal Logic
    
    
    private func populateSpreads(withDictionary dictionary: [String: Any]?,
                                 inContext context: NSManagedObjectContext) {
        if let spreadsData = dictionary?[Constants.Tables.Spread] {
            if spreadsData is [[String: Any]] {
                for data in spreadsData as! [[String: Any]] {
                    let spread = Spread(context: context)
                    spread.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func populateLabourSpreads(withDictionary dictionary: [String: Any]?,
                                       inContext context: NSManagedObjectContext) {
        if let labourSpreadsData = dictionary?[Constants.Tables.LabourSpread] {
            if labourSpreadsData is [[String: Any]] {
                for data in labourSpreadsData as! [[String: Any]] {
                    let labourSpread = LabourSpread(context: context)
                    labourSpread.fill(withDictionary: data)
                }
            }
        }
    }
}
