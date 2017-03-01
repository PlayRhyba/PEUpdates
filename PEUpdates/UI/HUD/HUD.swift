//
//  HUD.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 3/1/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import SVProgressHUD


class HUD: SVProgressHUD {
    
    enum CancellationMode {
        case Network
    }
    
    
    //MARK: SVProgressHUD
    
    
    override class func dismiss() {
        removeTouchObserver()
        super.dismiss()
    }
    
    
    deinit {
        type(of: self).removeTouchObserver()
    }
    
    
    //MARK: Public Methods
    
    
    class func configure() {
        setDefaultMaskType(.black)
    }
    
    
    class func show(cancellationMode: CancellationMode) {
        switch cancellationMode {
        case .Network: addTouchObserver(selector: #selector(cancelNetworkOperations))
        }
        
        show()
    }
    
    
    //MARK: Internal Logic
    
    
    @objc private class func cancelNetworkOperations() {
        ServiceManager.sharedInstance.cancellAllOperations()
        dismiss()
    }
    
    
    private class func addTouchObserver(selector: Selector) {
        NotificationCenter.default.addObserver(self,
                                               selector: selector,
                                               name: .SVProgressHUDDidTouchDownInside,
                                               object: nil)
    }
    
    
    private class func removeTouchObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: .SVProgressHUDDidTouchDownInside,
                                                  object: nil)
    }
}
