//
//  ViewController.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/7/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit
import SVProgressHUD


class ViewController: UIViewController {
    
    let server = "https://enbridge.pipelineenterprise.com/mobile"
    let email = "peinspector@metegrity.com"
    let password = "Default29)"
    
    
    //MARK: Lifecycle Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: IBAction
    
    
    @IBAction func loginButtonClicked(sender: UIButton) {
        SVProgressHUD.show()
        
        PPEServiceGateway.authenticate(email: email,
                                       password: password,
                                       server: server,
                                       success: { (profile) in
                                        SVProgressHUD.showSuccess(withStatus: String(format: "Logged in. User: %@",
                                                                                     profile.name ?? "Unknown"))
        },
                                       failure: { (response, error) in
                                        SVProgressHUD.showError(withStatus: error.localizedDescription)
        })
    }
    
    
    @IBAction func loadDataButtonClicked(sender: UIButton) {
        SVProgressHUD.show()
        
        PPEServiceGateway.loadData(email: email,
                                   password: password,
                                   server: server,
                                   success: {
                                    SVProgressHUD.showSuccess(withStatus: "Data have been loaded")
        }, failure: { (response, error) in
            SVProgressHUD.showError(withStatus: error.localizedDescription)
        }, progress: nil)
    }
}

