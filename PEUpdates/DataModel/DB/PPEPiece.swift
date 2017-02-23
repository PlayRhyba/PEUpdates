//
//  PPEPiece.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-23.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


@objc class PPEPiece: PPEBaseDBDataModel {
    
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
    @NSManaged public var length_meters: Double
    @NSManaged public var bendRadius: String?
    @NSManaged public var bendAngleDegrees: Double
    @NSManaged public var p_description: String?
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
    
    
    //MARK: PPEDataModel
    
    
    override var tableName: String {
        return Constants.Tables.Piece
    }
}
