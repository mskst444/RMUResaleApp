//
//  EditAccountViewController.swift
//  RMUResaleApp
//
//  Created by user152037 on 4/17/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit

class EditAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //set up constants for Invalid Entry alerts
    let invalidPasswordAlert = UIAlertController(title: "Invalid Entry", message: "Please enter a valid password", preferredStyle: .alert)
    
    let invalidEmail = UIAlertController(title: "Invalid Entry", message: "Please enter a valid Email Address", preferredStyle: .alert)
    
    let closeAlertAction = UIAlertAction(title: "Close", style: .default)

}
