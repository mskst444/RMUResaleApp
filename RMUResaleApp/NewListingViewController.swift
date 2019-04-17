//
//  NewListingViewController.swift
//  RMUResaleApp
//
//  Created by Jacob Wright on 4/16/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit

class NewListingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.newTitle.delegate = self
        self.newPrice.delegate = self
        self.newISBN.delegate = self
        self.newAuthor.delegate = self
        
    }
   
    let alert = UIAlertController(title: "Invalid Entry", message: "Invalid Entry", preferredStyle: .alert)
    
    let closeAlertAction = UIAlertAction(title: "Close", style: .default)
    
    alert.addAction(closeAlertAction)
    
    if(self.newTitle.text = "" ||
        self.newPrice.text = "" ||
        self.newISBN.text = "" ||
        self.newAuthor.text = "")
    {
    present(alert, animated:true)
    }
    
    
}
