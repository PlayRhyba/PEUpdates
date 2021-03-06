//
//  ConfigurationManager.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-13.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class ConfigurationManager: NSObject {
    
    struct LocalConstants {
        static let Separator = "__"
    }
    
    
    static let shared = ConfigurationManager()
    private lazy var fields = [String: FieldDescription]()
    
    
    //MARK: NSObject
    
    
    private override init() {}
    
    
    //MARK: Public Methods
    
    
    func load(withCompletion completion: ((Bool, Error?) -> Void)?) {
        let invokeCompletion: (Bool, Error?) -> Void = { (success, error) in
            DispatchQueue.main.async {
                if let block = completion {
                    block(success, error)
                }
            }
        }
        
        DispatchQueue.global().async {
            self.clear()
            
            let fieldsFolderPath = Bundle.main.resourcePath?.appending("/Configuration/Fields")
            
            do {
                let fieldsFilePaths = try FileManager.default.contentsOfDirectory(atPath: fieldsFolderPath!)
                
                for file in fieldsFilePaths {
                    let path = URL(fileURLWithPath: fieldsFolderPath!).appendingPathComponent(file)
                    let data = try Data(contentsOf: path)
                    let tableName = self.extractTableName(fileName: file)
                    
                    if let dictionaries = try JSONSerialization.jsonObject(with: data,
                                                                           options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: Any]] {
                        for dictionary in dictionaries {
                            let fieldDescription = FieldDescription(withDictionary: dictionary)
                            
                            if fieldDescription.tableName == nil {
                                fieldDescription.tableName = tableName
                            }
                            
                            let key = self.keyName(fieldName: fieldDescription.propertyName, tableName: fieldDescription.tableName!)
                            self.fields[key] = fieldDescription
                        }
                    }
                    else {
                        invokeCompletion(false, Errors.configurationDataFormatError())
                    }
                }
            }
            catch {
                invokeCompletion(false, error)
            }
            
            invokeCompletion(true, nil)
        }
    }
    
    
    func clear() {
        fields.removeAll()
    }
    
    
    func isLoaded() -> Bool {
        return !fields.isEmpty
    }
    
    
    func fieldDesctiption(propertyName: String, table: String) -> FieldDescription? {
        return fields[keyName(fieldName: propertyName, tableName: table)]
    }
    
    
    //MARK: Internal Logic
    
    
    func extractTableName(fileName: String) -> String? {
        let name = (fileName as NSString).deletingPathExtension
        let nameComponents = name.components(separatedBy: LocalConstants.Separator)
        
        if nameComponents.count == 2 {
            return nameComponents[1]
        }
        
        return nil
    }
    
    
    func keyName(fieldName: String, tableName: String) -> String {
        return fieldName + LocalConstants.Separator + tableName
    }
}
