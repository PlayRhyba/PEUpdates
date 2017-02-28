//
//  Piece.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-23.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


@objc class Piece: BaseDBDataModel {
    
    @NSManaged public var pieceUUID: String?
    @NSManaged public var spreadID: NSNumber?
    @NSManaged public var pieceNumber: String?
    @NSManaged public var jointNumber: String?
    @NSManaged public var mTRNumber: String?
    @NSManaged public var heatNumber: String?
    @NSManaged public var shawNumber: String?
    @NSManaged public var manufacturer: String?
    @NSManaged public var material: String?
    @NSManaged public var materialGrade: String?
    @NSManaged public var pieceTypeGroup: String?
    @NSManaged public var pieceType: String?
    @NSManaged public var nPSDN: String?
    @NSManaged public var schedule: String?
    @NSManaged public var wallThickness_mm: String?
    @NSManaged public var outsideDiameter_mm: String?
    @NSManaged public var innerDiameter_mm: String?
    @NSManaged public var nPSDN2: String?
    @NSManaged public var schedule2: String?
    @NSManaged public var wallThickness2_mm: String?
    @NSManaged public var outsideDiameter2_mm: String?
    @NSManaged public var innerDiameter2_mm: String?
    @NSManaged public var length_meters: NSNumber?
    @NSManaged public var bendRadius: String?
    @NSManaged public var bendAngleDegrees: NSNumber?
    @NSManaged public var descriptionText: String?
    @NSManaged public var coating: String?
    @NSManaged public var pieceLat: String?
    @NSManaged public var pieceLong: String?
    @NSManaged public var barcodeA1: String?
    @NSManaged public var barcodeA2: String?
    @NSManaged public var barcodeA3: String?
    @NSManaged public var barcodeB1: String?
    @NSManaged public var barcodeB2: String?
    @NSManaged public var barcodeB3: String?
    @NSManaged public var pup1Number: String?
    @NSManaged public var pup1HeatNumber: String?
    @NSManaged public var pup1Coil: String?
    @NSManaged public var pup2Number: String?
    @NSManaged public var pup2HeatNumber: String?
    @NSManaged public var pup2Coil: String?
    @NSManaged public var pup3Number: String?
    @NSManaged public var pup3HeatNumber: String?
    @NSManaged public var pup3Coil: String?
    
    
    //MARK: BaseDBDataModel
    
    
    override func fill(withDictionary dictionary: [String: Any]?) {
        super.fill(withDictionary: dictionary)
        
        if let d = dictionary {
            autoreleasepool {
                pieceUUID = value(fromDictionary: d, propertyName: #keyPath(pieceUUID)) as? String
                spreadID = value(fromDictionary: d, propertyName: #keyPath(spreadID)) as? NSNumber
                pieceNumber = value(fromDictionary: d, propertyName: #keyPath(pieceNumber)) as? String
                jointNumber = value(fromDictionary: d, propertyName: #keyPath(jointNumber)) as? String
                mTRNumber = value(fromDictionary: d, propertyName: #keyPath(mTRNumber)) as? String
                heatNumber = value(fromDictionary: d, propertyName: #keyPath(heatNumber)) as? String
                shawNumber = value(fromDictionary: d, propertyName: #keyPath(shawNumber)) as? String
                manufacturer = value(fromDictionary: d, propertyName: #keyPath(manufacturer)) as? String
                material = value(fromDictionary: d, propertyName: #keyPath(material)) as? String
                materialGrade = value(fromDictionary: d, propertyName: #keyPath(materialGrade)) as? String
                pieceTypeGroup = value(fromDictionary: d, propertyName: #keyPath(pieceTypeGroup)) as? String
                pieceType = value(fromDictionary: d, propertyName: #keyPath(pieceType)) as? String
                nPSDN = value(fromDictionary: d, propertyName: #keyPath(nPSDN)) as? String
                schedule = value(fromDictionary: d, propertyName: #keyPath(schedule)) as? String
                wallThickness_mm = value(fromDictionary: d, propertyName: #keyPath(wallThickness_mm)) as? String
                outsideDiameter_mm = value(fromDictionary: d, propertyName: #keyPath(outsideDiameter_mm)) as? String
                innerDiameter_mm = value(fromDictionary: d, propertyName: #keyPath(innerDiameter_mm)) as? String
                nPSDN2 = value(fromDictionary: d, propertyName: #keyPath(nPSDN2)) as? String
                schedule2 = value(fromDictionary: d, propertyName: #keyPath(schedule2)) as? String
                wallThickness2_mm = value(fromDictionary: d, propertyName: #keyPath(wallThickness2_mm)) as? String
                outsideDiameter2_mm = value(fromDictionary: d, propertyName: #keyPath(outsideDiameter2_mm)) as? String
                innerDiameter2_mm = value(fromDictionary: d, propertyName: #keyPath(innerDiameter2_mm)) as? String
                length_meters = value(fromDictionary: d, propertyName: #keyPath(length_meters)) as? NSNumber
                bendRadius = value(fromDictionary: d, propertyName: #keyPath(bendRadius)) as? String
                bendAngleDegrees = value(fromDictionary: d, propertyName: #keyPath(bendAngleDegrees)) as? NSNumber
                descriptionText = value(fromDictionary: d, propertyName: #keyPath(descriptionText)) as? String
                coating = value(fromDictionary: d, propertyName: #keyPath(coating)) as? String
                pieceLat = value(fromDictionary: d, propertyName: #keyPath(pieceLat)) as? String
                pieceLong = value(fromDictionary: d, propertyName: #keyPath(pieceLong)) as? String
                barcodeA1 = value(fromDictionary: d, propertyName: #keyPath(barcodeA1)) as? String
                barcodeA2 = value(fromDictionary: d, propertyName: #keyPath(barcodeA2)) as? String
                barcodeA3 = value(fromDictionary: d, propertyName: #keyPath(barcodeA3)) as? String
                barcodeB1 = value(fromDictionary: d, propertyName: #keyPath(barcodeB1)) as? String
                barcodeB2 = value(fromDictionary: d, propertyName: #keyPath(barcodeB2)) as? String
                barcodeB3 = value(fromDictionary: d, propertyName: #keyPath(barcodeB3)) as? String
                pup1Number = value(fromDictionary: d, propertyName: #keyPath(pup1Number)) as? String
                pup1HeatNumber = value(fromDictionary: d, propertyName: #keyPath(pup1HeatNumber)) as? String
                pup1Coil = value(fromDictionary: d, propertyName: #keyPath(pup1Coil)) as? String
                pup2Number = value(fromDictionary: d, propertyName: #keyPath(pup2Number)) as? String
                pup2HeatNumber = value(fromDictionary: d, propertyName: #keyPath(pup2HeatNumber)) as? String
                pup2Coil = value(fromDictionary: d, propertyName: #keyPath(pup2Coil)) as? String
                pup3Number = value(fromDictionary: d, propertyName: #keyPath(pup3Number)) as? String
                pup3HeatNumber = value(fromDictionary: d, propertyName: #keyPath(pup3HeatNumber)) as? String
                pup3Coil = value(fromDictionary: d, propertyName: #keyPath(pup3Coil)) as? String
            }
        }
    }
    
    
    //MARK: DataModel
    
    
    override var tableName: String {
        return Constants.Tables.Piece
    }
}
