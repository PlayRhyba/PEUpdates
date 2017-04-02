//
//  NSObject+NibLoading.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 4/2/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


extension NSObject {
    class func load(fromNib nibName: String, owner: Any?) -> Any? {
        guard let objects = Bundle.main.loadNibNamed(nibName, owner: owner, options: nil) else {
            return nil
        }
        
        for object in objects {
            if self.self == type(of: object) {
                return object
            }
        }
        
        return nil
    }
    
    
    class func load(fromNib nibName: String) -> Any? {
        return load(fromNib: nibName, owner: nil)
    }
    
    
    class func loadFromNib() -> Any? {
        return load(fromNib: self.className)
    }
    
    
    class func nib() -> UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
}
