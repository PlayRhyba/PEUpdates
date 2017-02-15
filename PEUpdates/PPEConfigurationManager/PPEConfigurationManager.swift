//
//  PPEConfigurationManager.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-13.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class PPEConfigurationManager: NSObject {
    
    struct LocalConstants {
        static let Separator = "__"
    }
    
    
    static let sharedInstance = PPEConfigurationManager()
    private lazy var fields = [String: PPEFieldDescription]()
    
    
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
                    
                    let objects = try JSONSerialization.jsonObject(with: data,
                                                                   options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: Any]]
                    
                    let tableName = self.extractTableName(fileName: file)
                    
                    if let dictionaries = objects {
                        for dictionary in dictionaries {
                            let fieldDescription = PPEFieldDescription(withDictionary: dictionary)
                            
                            if (fieldDescription.tableName == nil) {
                                fieldDescription.tableName = tableName
                            }
                            
                            let key = self.keyName(fieldName: fieldDescription.type!, tableName: fieldDescription.tableName!)
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
    
    
    func fieldDesctiption(name: String, table: String) -> PPEFieldDescription? {
        var key = keyName(fieldName: name, tableName: table)
        var field = fields[key]
        
        if (field == nil) {
            key = keyName(fieldName: name.capitalizingFirstLetter(), tableName: table)
            field = fields[key]
        }
        
        return field
    }
    
    
    //MARK: Internal Logic
    
    
    func extractTableName(fileName: String) -> String? {
        let name = (fileName as NSString).deletingPathExtension
        let nameComponents = name.components(separatedBy: LocalConstants.Separator)
        
        if (nameComponents.count == 2) {
            return nameComponents[1]
        }
        
        return nil
    }
    
    
    func keyName(fieldName: String, tableName: String) -> String {
        return String(format: "%@%@%@", fieldName, LocalConstants.Separator, tableName)
    }
}
