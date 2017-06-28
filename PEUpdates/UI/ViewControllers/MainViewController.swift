//
//  MainViewController.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/7/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


class MainViewController: UIViewController {
    
    let server = "https://dev.pipelineenterprise.com/mobile"
    let email = "peinspector@metegrity.com"
    let password = "Default29)"
    
    
    //MARK: Lifecycle Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
    }
    
    
    //MARK: IBAction
    
    
    @IBAction func loginButtonClicked(sender: UIButton) {
        HUD.show(cancellationMode: .network)
        
        ServiceGateway.authenticate(email: email,
                                    password: password,
                                    server: server) { result in
                                        if result.isSuccess {
                                            HUD.showSuccess(withStatus: "Logged in. User: \(result.value?.name ?? "Unknown")")
                                        }
                                        else {
                                            HUD.showError(withStatus: result.error!.localizedDescription)
                                        }
        }
    }
    
    
    @IBAction func loadDataButtonClicked(sender: UIButton) {
        HUD.show(cancellationMode: .network)
        
        ServiceGateway.loadData(email: email,
                                password: password,
                                server: server) { result in
                                    if result.isSuccess {
                                        HUD.showSuccess(withStatus: "Data have been loaded")
                                    }
                                    else {
                                        HUD.showError(withStatus: result.error!.localizedDescription)
                                    }
        }
    }
    
    
    @IBAction func clearDataButtonClicked(sender: UIButton) {
        do {
            try DataStorage.shared.clear()
        }
        catch {
            HUD.showError(withStatus: error.localizedDescription)
        }
    }
}

