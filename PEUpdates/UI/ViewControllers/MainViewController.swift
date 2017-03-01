//
//  MainViewController.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/7/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


class MainViewController: UIViewController {
    
    let server = "https://demo.pipelineenterprise.com/mobile"
    let email = "bjmarsh@telus.net"
    let password = "Metegrity3!"
    
    
    //MARK: Lifecycle Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
    }
    
    
    //MARK: IBAction
    
    
    @IBAction func loginButtonClicked(sender: UIButton) {
        HUD.show()
        
        ServiceGateway.authenticate(email: email,
                                    password: password,
                                    server: server,
                                    success: { (profile) in
                                        HUD.showSuccess(withStatus: "Logged in. User: \(profile.name ?? "Unknown")")
        },
                                    failure: { (response, error) in
                                        HUD.showError(withStatus: error.localizedDescription)
        })
    }
    
    
    @IBAction func loadDataButtonClicked(sender: UIButton) {
        HUD.show()
        
        ServiceGateway.loadData(email: email,
                                password: password,
                                server: server,
                                success: {
                                    HUD.showSuccess(withStatus: "Data have been loaded")
        }, failure: { (response, error) in
            HUD.showError(withStatus: error.localizedDescription)
        }, progress: nil)
    }
}

