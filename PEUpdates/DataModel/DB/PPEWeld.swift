//
//  PPEWeld.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-20.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


@objc class PPEWeld: PPEBaseDBDataModel {
    
    @NSManaged public var weldUUID: String?
    @NSManaged public var jobID: NSNumber?
    @NSManaged public var spreadID: NSNumber?
    @NSManaged public var spreadPrefix: String?
    @NSManaged public var crewPrefix: String?
    @NSManaged public var weldIndex: String?
    @NSManaged public var weldHistory: String?
    @NSManaged public var weldNumber: String?
    @NSManaged public var wPSNumber: String?
    @NSManaged public var weldingCode: String?
    @NSManaged public var weldingProcess: String?
    @NSManaged public var weldStatus: String?
    @NSManaged public var weldDate: NSDate?
    @NSManaged public var inspectorName: String?
    @NSManaged public var weldComments: String?
    @NSManaged public var station: String?
    @NSManaged public var weldLat: NSNumber?
    @NSManaged public var weldLong: NSNumber?
    @NSManaged public var weldElevation: NSNumber?
    @NSManaged public var heatNumber1: String?
    @NSManaged public var heatNumber2: String?
    @NSManaged public var pieceNumber1: String?
    @NSManaged public var pieceNumber2: String?
    @NSManaged public var weldAuditDate: NSDate?
    @NSManaged public var weldAuditAccRej: String?
    @NSManaged public var weldAuditBy: String?
    @NSManaged public var counted: NSNumber?
    @NSManaged public var asBuilt: NSNumber?
    @NSManaged public var weldAuditComment: String?
    @NSManaged public var foremanName: String?
    @NSManaged public var weldingUnitNumber: String?
    @NSManaged public var wallThickness1: String?
    @NSManaged public var wallThickness2: String?
    @NSManaged public var weldType: String?
    @NSManaged public var previousWeldUUID: String?
    @NSManaged public var contractorCompanyName: String?
    @NSManaged public var lineUpInspectorName: String?
    @NSManaged public var lineUpInspectorUsername: String?
    @NSManaged public var lineUpDate: NSDate?
    @NSManaged public var lineUpClampType: String?
    @NSManaged public var jointNumber1: String?
    @NSManaged public var jointNumber2: String?
    @NSManaged public var outsideDiameter1: NSNumber?
    @NSManaged public var outsideDiameter2: NSNumber?
    @NSManaged public var xAxisOvality1: NSNumber?
    @NSManaged public var xAxisOvality2: NSNumber?
    @NSManaged public var yAxisOvality1: NSNumber?
    @NSManaged public var yAxisOvality2: NSNumber?
    @NSManaged public var xYOvalityVariance1: NSNumber?
    @NSManaged public var yYOvalityVariance2: NSNumber?
    @NSManaged public var bellAndCrimp1: NSNumber?
    @NSManaged public var bellAndCrimp2: NSNumber?
    @NSManaged public var internalSeamGrind1: NSNumber?
    @NSManaged public var internalSeamGrind2: NSNumber?
    @NSManaged public var noseGMAWBevelPrep1: NSNumber?
    @NSManaged public var noseGMAWBevelPrep2: NSNumber?
    @NSManaged public var offsetGMAWBevelPrep1: NSNumber?
    @NSManaged public var offsetGMAWBevelPrep2: NSNumber?
    @NSManaged public var angleSMAWBevelPrep1: NSNumber?
    @NSManaged public var angleSMAWBevelPrep2: NSNumber?
    @NSManaged public var landSMAWBevelPrep1: NSNumber?
    @NSManaged public var landSMAWBevelPrep2: NSNumber?
    @NSManaged public var highLowInspectorName: String?
    @NSManaged public var highLowInspectorUsername: String?
    @NSManaged public var highLowDate: NSDate?
    @NSManaged public var hiLow0Location: NSNumber?
    @NSManaged public var hiLow90Location: NSNumber?
    @NSManaged public var hiLow180Location: NSNumber?
    @NSManaged public var hiLow270Location: NSNumber?
    @NSManaged public var repair: NSNumber?
    @NSManaged public var cutout: NSNumber?
    @NSManaged public var defectAndQuadrant: String?
    @NSManaged public var lineUpComment: String?
    @NSManaged public var transitionDate: NSDate?
    @NSManaged public var transitionNumber: String?
    @NSManaged public var transitionPieceNumber: String?
    @NSManaged public var q1Q3OvalityID: NSNumber?
    @NSManaged public var q2Q4OvalityID: NSNumber?
    @NSManaged public var amountOvalityID: NSNumber?
    @NSManaged public var q1WallThickness: NSNumber?
    @NSManaged public var q2WallThickness: NSNumber?
    @NSManaged public var q3WallThickness: NSNumber?
    @NSManaged public var q4WallThickness: NSNumber?
    @NSManaged public var taperAngle: NSNumber?
    @NSManaged public var counterBoreLength: NSNumber?
    @NSManaged public var weldBevelAngle: NSNumber?
    @NSManaged public var backBevelAngle: NSNumber?
    @NSManaged public var transitionWallThickness: NSNumber?
    @NSManaged public var transitionAcceptable: NSNumber?
    @NSManaged public var transitionComments: String?
    @NSManaged public var transitionInspectorName: String?
    @NSManaged public var transitionInspectorUsername: String?
    @NSManaged public var transitionType: String?
    @NSManaged public var pieceUUID1: String?
    @NSManaged public var pieceUUID2: String?
    @NSManaged public var repairCutoutDate: NSDate?
    @NSManaged public var installLength1: String?
    @NSManaged public var installLength2: String?
    @NSManaged public var lengthCut1: String?
    @NSManaged public var lengthCut2: String?
    
    
    //MARK: PPEDataModel
    
    
    override var tableName: String {
        return Constants.Tables.Weld
    }
}
