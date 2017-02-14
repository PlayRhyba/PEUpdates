//
//  NSObject+Utilities.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-14.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import CocoaLumberjack


extension (NSObject) {
    
    
    //MARK: Public Methods
    
    
    func propertiesInfo() -> [String: Any] {
        var result = [String: Any]()
        var count = UInt32()
        let properties = class_copyPropertyList(self.classForCoder, &count)
        
        if properties != nil && count > 0 {
            for i in 0 ..< Int(count) {
                let property = properties![i]
                
                guard let name = self.nameOf(property: property!) else {
                    DDLogWarn("NSOBJECT REFLECTION: COULDN'T UNWRAP PROPERTY NAME FOR \(property)")
                    continue
                }
                
                result[name] = typeOf(property: property!)
            }
        }
        
        free(properties)
        
        return result
    }
    
    
    //MARK: Internal Logic
    
    
    private func nameOf(property: objc_property_t) -> String? {
        guard let name = NSString(utf8String: property_getName(property)) else {
            return nil
        }
        
        return name as String
    }
    
    
    private func typeOf(property: objc_property_t) -> Any {
        guard let attributesAsNSString = NSString(utf8String: property_getAttributes(property)) else {
            return Any.self
        }
        
        let attributes = attributesAsNSString as String
        let components = attributes.components(separatedBy: "\"")
        
        guard components.count > 1 else {
            return valueType(withAttributes: attributes)
        }
        
        let objectClassName = components[1]
        let objectClass = NSClassFromString(objectClassName) as! NSObject.Type
        
        return objectClass
    }
    
    
    private struct LocalConstants {
        static let ValueTypesMap: Dictionary<String, Any> = [
            "c": Int8.self,
            "s": Int16.self,
            "i": Int32.self,
            "q": Int.self,     //also: Int64, NSInteger, only true on 64 bit platforms
            "S": UInt16.self,
            "I": UInt32.self,
            "Q": UInt.self,    //also UInt64, only true on 64 bit platforms
            "B": Bool.self,
            "d": Double.self,
            "f": Float.self,
            "{": Decimal.self
        ]
    }
    
    
    private func valueType(withAttributes attributes: String) -> Any {
        let index = attributes.index(attributes.startIndex, offsetBy: 1)
        let letter = attributes[index...index]
        
        guard  let type = LocalConstants.ValueTypesMap[letter] else {
            return Any.self
        }
        
        return type
    }
}
