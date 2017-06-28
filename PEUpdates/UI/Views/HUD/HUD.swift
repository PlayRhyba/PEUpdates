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
        case no
        case network
    }
    
    
    private static var cancellationMode: CancellationMode = .no
    
    
    //MARK: SVProgressHUD
    
    
    override class func dismiss() {
        cancellationMode = .no
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
        self.cancellationMode = cancellationMode
        
        switch self.cancellationMode {
        case .no: break
        case .network: addTouchObserver()
        }
        
        show()
    }
    
    
    //MARK: Internal Logic
    
    
    @objc private class func cancel() {
        switch cancellationMode {
        case .no: break
        case .network:
            RequestManager.shared.cancelAllOperations()
            dismiss()
        }
    }
    
    
    private class func addTouchObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cancel),
                                               name: .SVProgressHUDDidTouchDownInside,
                                               object: nil)
    }
    
    
    private class func removeTouchObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: .SVProgressHUDDidTouchDownInside,
                                                  object: nil)
    }
}
