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
    
    
    func saveWeldData(dictionaries: [[String: Any]]?, completion: CompletionBlock?) {
        MagicalRecord.save({ (localContext) in
            if let objects = dictionaries {
                self.clearWeldData(localContext: localContext)
                
                for dictionary in objects {
                    self.saveWelds(withDictionary: dictionary, localContext: localContext)
                    self.savePieces(withDictionary: dictionary, localContext: localContext)
                    
                    
                    //TODO: Handle other models
                    
                    
                }
            }
        }, completion: completion)
    }
    
    
    //MARK: Internal Logic
    
    
    private func saveWelds(withDictionary dictionary: [String: Any]?,
                           localContext: NSManagedObjectContext) {
        if let weldsData = dictionary?[Constants.Tables.Weld] {
            if weldsData is [[String: Any]] {
                for data in (weldsData as! [[String: Any]]) {
                    let weld = PPEWeld.mr_createEntity(in: localContext)
                    weld?.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func savePieces(withDictionary dictionary: [String: Any]?,
                            localContext: NSManagedObjectContext) {
        if let piecesData = dictionary?[Constants.Tables.Piece] {
            if piecesData is [[String: Any]] {
                for data in piecesData as! [[String: Any]] {
                    let piece = PPEPiece.mr_createEntity(in: localContext)
                    piece?.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func clearWeldData(localContext: NSManagedObjectContext) {
        PPEWeld.mr_truncateAll(in: localContext)
        PPEPiece.mr_truncateAll(in: localContext)
        
        
        //TODO: Clear other models
        
        
    }
}
