//
//  DataStorage+WeldData.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-20.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


extension DataStorage {
    
    func welds(completionHandler: @escaping ((OperationResult<[NSManagedObject]>) -> Void)) {
        Weld.performAsynchroniuosFetch(requestConfiguration: { fetchRequest in
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Weld.weldNumber), ascending: true)]
        }, inContext: persistentContainer.viewContext, completionHandler: completionHandler)
    }
    
    
    func pieces(completionHandler: @escaping ((OperationResult<[NSManagedObject]>) -> Void)) {
        Piece.performAsynchroniuosFetch(requestConfiguration: { fetchRequest in
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Piece.pieceNumber), ascending: true)]
        }, inContext: persistentContainer.viewContext, completionHandler: completionHandler)
    }
    
    
    func populateWeldData(withDictionaries dictionaries: [[String: Any]]?, completionHandler: ((OperationResult<Void>) -> Void)?) {
        if let dictionaries = dictionaries {
            persistentContainer.performBackgroundTask { [unowned self] context in
                self.clearWeldData(inContext: context)
                
                for dictionary in dictionaries {
                    self.populateWelds(withDictionary: dictionary, inContext: context)
                    self.populatePieces(withDictionary: dictionary, inContext: context)
                    
                    
                    //TODO: Handle other models
                    
                    
                }
                
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
    
    
    func clearWeldData(inContext context: NSManagedObjectContext) {
        Weld.deleteAll(inContext: context)
        Piece.deleteAll(inContext: context)
        
        
        //TODO: Clear other models
        
        
    }
    
    
    //MARK: Internal Logic
    
    
    private func populateWelds(withDictionary dictionary: [String: Any]?,
                               inContext context: NSManagedObjectContext) {
        if let weldsData = dictionary?[Constants.Tables.Weld] {
            if weldsData is [[String: Any]] {
                for data in (weldsData as! [[String: Any]]) {
                    let weld = Weld(context: context)
                    weld.fill(withDictionary: data)
                }
            }
        }
    }
    
    
    private func populatePieces(withDictionary dictionary: [String: Any]?,
                                inContext context: NSManagedObjectContext) {
        if let piecesData = dictionary?[Constants.Tables.Piece] {
            if piecesData is [[String: Any]] {
                for data in piecesData as! [[String: Any]] {
                    let piece = Piece(context: context)
                    piece.fill(withDictionary: data)
                }
            }
        }
    }
}
