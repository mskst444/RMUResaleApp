//
//  NewBookViewController.swift
//  RMUResaleApp
//
//  Created by Jacob Wright on 4/17/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit

class NewBookViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var newTitle: UITextField!
    @IBOutlet weak var newPrice: UITextField!
    @IBOutlet weak var newISBN: UITextField!
    @IBOutlet weak var newAuthor: UITextField!
    
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayEmail: UILabel!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.newTitle.delegate = self
        self.newPrice.delegate = self
        self.newISBN.delegate  = self
        self.newAuthor.delegate = self
    }
    
    
    
    
    
    @IBAction func newListing(_ sender: Any) {
        
        
    }
    
    
    
    
    
}
