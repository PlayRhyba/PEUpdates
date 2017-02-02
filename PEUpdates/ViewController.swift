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
    @IBOutlet weak var loginButton: UIButton?;
    
    
    //MARK: Lifecycle Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: IBAction
    
    
    @IBAction func loginButtonClicked(sender: UIButton) {
        SVProgressHUD.show()
        
        PPEServiceGateway.authenticate(email: "peinspector@metegrity.com",
                                       password: "Default29)",
                                       server: "https://dev.pipelineenterprise.com/mobile",
                                       success: { (response, data) in
                                        SVProgressHUD.showSuccess(withStatus: String(format: "Logged in. User: %@",
                                                                                     (data as? PPEProfile)?.name ?? "Unknown"))
        },
                                       failure: { (response, error) in
                                        SVProgressHUD.showError(withStatus: error.localizedDescription)
        })
    }
}

