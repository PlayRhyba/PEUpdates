//
//  Weld.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-20.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


@objc class Weld: BaseDBDataModel {
    
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
    @NSManaged public var xYOvalityVariance2: NSNumber?
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
    
    
    //MARK: BaseDBDataModel
    
    
    override func fill(withDictionary dictionary: [String: Any]?) {
        super.fill(withDictionary: dictionary)
        
        if let d = dictionary {
            autoreleasepool {
                weldUUID = value(fromDictionary: d, propertyName: #keyPath(weldUUID)) as? String
                jobID = value(fromDictionary: d, propertyName: #keyPath(jobID)) as? NSNumber
                spreadID = value(fromDictionary: d, propertyName: #keyPath(spreadID)) as? NSNumber
                spreadPrefix = value(fromDictionary: d, propertyName: #keyPath(spreadPrefix)) as? String
                crewPrefix = value(fromDictionary: d, propertyName: #keyPath(crewPrefix)) as? String
                weldIndex = value(fromDictionary: d, propertyName: #keyPath(weldIndex)) as? String
                weldHistory = value(fromDictionary: d, propertyName: #keyPath(weldHistory)) as? String
                weldNumber = value(fromDictionary: d, propertyName: #keyPath(weldNumber)) as? String
                wPSNumber = value(fromDictionary: d, propertyName: #keyPath(wPSNumber)) as? String
                weldingCode = value(fromDictionary: d, propertyName: #keyPath(weldingCode)) as? String
                weldingProcess = value(fromDictionary: d, propertyName: #keyPath(weldingProcess)) as? String
                weldStatus = value(fromDictionary: d, propertyName: #keyPath(weldStatus)) as? String
                weldDate = value(fromDictionary: d, propertyName: #keyPath(weldDate), processingMode: .date) as? NSDate
                inspectorName = value(fromDictionary: d, propertyName: #keyPath(inspectorName)) as? String
                weldComments = value(fromDictionary: d, propertyName: #keyPath(weldComments)) as? String
                station = value(fromDictionary: d, propertyName: #keyPath(station)) as? String
                weldLat = value(fromDictionary: d, propertyName: #keyPath(weldLat)) as? NSNumber
                weldLong = value(fromDictionary: d, propertyName: #keyPath(weldLong)) as? NSNumber
                weldElevation = value(fromDictionary: d, propertyName: #keyPath(weldElevation)) as? NSNumber
                heatNumber1 = value(fromDictionary: d, propertyName: #keyPath(heatNumber1)) as? String
                heatNumber2 = value(fromDictionary: d, propertyName: #keyPath(heatNumber2)) as? String
                pieceNumber1 = value(fromDictionary: d, propertyName: #keyPath(pieceNumber1)) as? String
                pieceNumber2 = value(fromDictionary: d, propertyName: #keyPath(pieceNumber2)) as? String
                weldAuditDate = value(fromDictionary: d, propertyName: #keyPath(weldAuditDate), processingMode: .date) as? NSDate
                weldAuditAccRej = value(fromDictionary: d, propertyName: #keyPath(weldAuditAccRej)) as? String
                weldAuditBy = value(fromDictionary: d, propertyName: #keyPath(weldAuditBy)) as? String
                counted = value(fromDictionary: d, propertyName: #keyPath(counted)) as? NSNumber
                asBuilt = value(fromDictionary: d, propertyName: #keyPath(asBuilt)) as? NSNumber
                weldAuditComment = value(fromDictionary: d, propertyName: #keyPath(weldAuditComment)) as? String
                foremanName = value(fromDictionary: d, propertyName: #keyPath(foremanName)) as? String
                weldingUnitNumber = value(fromDictionary: d, propertyName: #keyPath(weldingUnitNumber)) as? String
                wallThickness1 = value(fromDictionary: d, propertyName: #keyPath(wallThickness1)) as? String
                wallThickness2 = value(fromDictionary: d, propertyName: #keyPath(wallThickness2)) as? String
                weldType = value(fromDictionary: d, propertyName: #keyPath(weldType)) as? String
                previousWeldUUID = value(fromDictionary: d, propertyName: #keyPath(previousWeldUUID)) as? String
                contractorCompanyName = value(fromDictionary: d, propertyName: #keyPath(contractorCompanyName)) as? String
                lineUpInspectorName = value(fromDictionary: d, propertyName: #keyPath(lineUpInspectorName)) as? String
                lineUpInspectorUsername = value(fromDictionary: d, propertyName: #keyPath(lineUpInspectorUsername)) as? String
                lineUpDate = value(fromDictionary: d, propertyName: #keyPath(lineUpDate), processingMode: .date) as? NSDate
                lineUpClampType = value(fromDictionary: d, propertyName: #keyPath(lineUpClampType)) as? String
                jointNumber1 = value(fromDictionary: d, propertyName: #keyPath(jointNumber1)) as? String
                jointNumber2 = value(fromDictionary: d, propertyName: #keyPath(jointNumber2)) as? String
                outsideDiameter1 = value(fromDictionary: d, propertyName: #keyPath(outsideDiameter1)) as? NSNumber
                outsideDiameter2 = value(fromDictionary: d, propertyName: #keyPath(outsideDiameter2)) as? NSNumber
                xAxisOvality1 = value(fromDictionary: d, propertyName: #keyPath(xAxisOvality1)) as? NSNumber
                xAxisOvality2 = value(fromDictionary: d, propertyName: #keyPath(xAxisOvality2)) as? NSNumber
                yAxisOvality1 = value(fromDictionary: d, propertyName: #keyPath(yAxisOvality1)) as? NSNumber
                yAxisOvality2 = value(fromDictionary: d, propertyName: #keyPath(yAxisOvality2)) as? NSNumber
                xYOvalityVariance1 = value(fromDictionary: d, propertyName: #keyPath(xYOvalityVariance1)) as? NSNumber
                xYOvalityVariance2 = value(fromDictionary: d, propertyName: #keyPath(xYOvalityVariance2)) as? NSNumber
                bellAndCrimp1 = value(fromDictionary: d, propertyName: #keyPath(bellAndCrimp1)) as? NSNumber
                bellAndCrimp2 = value(fromDictionary: d, propertyName: #keyPath(bellAndCrimp2)) as? NSNumber
                internalSeamGrind1 = value(fromDictionary: d, propertyName: #keyPath(internalSeamGrind1)) as? NSNumber
                internalSeamGrind2 = value(fromDictionary: d, propertyName: #keyPath(internalSeamGrind2)) as? NSNumber
                noseGMAWBevelPrep1 = value(fromDictionary: d, propertyName: #keyPath(noseGMAWBevelPrep1)) as? NSNumber
                noseGMAWBevelPrep2 = value(fromDictionary: d, propertyName: #keyPath(noseGMAWBevelPrep2)) as? NSNumber
                offsetGMAWBevelPrep1 = value(fromDictionary: d, propertyName: #keyPath(offsetGMAWBevelPrep1)) as? NSNumber
                offsetGMAWBevelPrep2 = value(fromDictionary: d, propertyName: #keyPath(offsetGMAWBevelPrep2)) as? NSNumber
                angleSMAWBevelPrep1 = value(fromDictionary: d, propertyName: #keyPath(angleSMAWBevelPrep1)) as? NSNumber
                angleSMAWBevelPrep2 = value(fromDictionary: d, propertyName: #keyPath(angleSMAWBevelPrep2)) as? NSNumber
                landSMAWBevelPrep1 = value(fromDictionary: d, propertyName: #keyPath(landSMAWBevelPrep1)) as? NSNumber
                landSMAWBevelPrep2 = value(fromDictionary: d, propertyName: #keyPath(landSMAWBevelPrep2)) as? NSNumber
                highLowInspectorName = value(fromDictionary: d, propertyName: #keyPath(highLowInspectorName)) as? String
                highLowInspectorUsername = value(fromDictionary: d, propertyName: #keyPath(highLowInspectorUsername)) as? String
                highLowDate = value(fromDictionary: d, propertyName: #keyPath(highLowDate), processingMode: .date) as? NSDate
                hiLow0Location = value(fromDictionary: d, propertyName: #keyPath(hiLow0Location)) as? NSNumber
                hiLow90Location = value(fromDictionary: d, propertyName: #keyPath(hiLow90Location)) as? NSNumber
                hiLow180Location = value(fromDictionary: d, propertyName: #keyPath(hiLow180Location)) as? NSNumber
                hiLow270Location = value(fromDictionary: d, propertyName: #keyPath(hiLow270Location)) as? NSNumber
                repair = value(fromDictionary: d, propertyName: #keyPath(repair)) as? NSNumber
                cutout = value(fromDictionary: d, propertyName: #keyPath(cutout)) as? NSNumber
                defectAndQuadrant = value(fromDictionary: d, propertyName: #keyPath(defectAndQuadrant)) as? String
                lineUpComment = value(fromDictionary: d, propertyName: #keyPath(lineUpComment)) as? String
                transitionDate = value(fromDictionary: d, propertyName: #keyPath(transitionDate), processingMode: .date) as? NSDate
                transitionNumber = value(fromDictionary: d, propertyName: #keyPath(transitionNumber)) as? String
                transitionPieceNumber = value(fromDictionary: d, propertyName: #keyPath(transitionPieceNumber)) as? String
                q1Q3OvalityID = value(fromDictionary: d, propertyName: #keyPath(q1Q3OvalityID)) as? NSNumber
                q2Q4OvalityID = value(fromDictionary: d, propertyName: #keyPath(q2Q4OvalityID)) as? NSNumber
                amountOvalityID = value(fromDictionary: d, propertyName: #keyPath(amountOvalityID)) as? NSNumber
                q1WallThickness = value(fromDictionary: d, propertyName: #keyPath(q1WallThickness)) as? NSNumber
                q2WallThickness = value(fromDictionary: d, propertyName: #keyPath(q2WallThickness)) as? NSNumber
                q3WallThickness = value(fromDictionary: d, propertyName: #keyPath(q3WallThickness)) as? NSNumber
                q4WallThickness = value(fromDictionary: d, propertyName: #keyPath(q4WallThickness)) as? NSNumber
                taperAngle = value(fromDictionary: d, propertyName: #keyPath(taperAngle)) as? NSNumber
                counterBoreLength = value(fromDictionary: d, propertyName: #keyPath(counterBoreLength)) as? NSNumber
                weldBevelAngle = value(fromDictionary: d, propertyName: #keyPath(weldBevelAngle)) as? NSNumber
                backBevelAngle = value(fromDictionary: d, propertyName: #keyPath(backBevelAngle)) as? NSNumber
                transitionWallThickness = value(fromDictionary: d, propertyName: #keyPath(transitionWallThickness)) as? NSNumber
                transitionAcceptable = value(fromDictionary: d, propertyName: #keyPath(transitionAcceptable)) as? NSNumber
                transitionComments = value(fromDictionary: d, propertyName: #keyPath(transitionComments)) as? String
                transitionInspectorName = value(fromDictionary: d, propertyName: #keyPath(transitionInspectorName)) as? String
                transitionInspectorUsername = value(fromDictionary: d, propertyName: #keyPath(transitionInspectorUsername)) as? String
                transitionType = value(fromDictionary: d, propertyName: #keyPath(transitionType)) as? String
                pieceUUID1 = value(fromDictionary: d, propertyName: #keyPath(pieceUUID1)) as? String
                pieceUUID2 = value(fromDictionary: d, propertyName: #keyPath(pieceUUID2)) as? String
                repairCutoutDate = value(fromDictionary: d, propertyName: #keyPath(repairCutoutDate), processingMode: .date) as? NSDate
                installLength1 = value(fromDictionary: d, propertyName: #keyPath(installLength1)) as? String
                installLength2 = value(fromDictionary: d, propertyName: #keyPath(installLength2)) as? String
                lengthCut1 = value(fromDictionary: d, propertyName: #keyPath(lengthCut1)) as? String
                lengthCut2 = value(fromDictionary: d, propertyName: #keyPath(lengthCut2)) as? String
            }
        }
    }
    
    
    //MARK: DataModel
    
    
    override var tableName: String {
        return Constants.Tables.Weld
    }
}
