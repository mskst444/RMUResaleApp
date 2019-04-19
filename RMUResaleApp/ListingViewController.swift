//
//  ListingViewController.swift
//  RMUResaleApp
//
//  Created by Jacob Wright on 4/18/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {
    
    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var listingPrice: UILabel!
    @IBOutlet weak var listingSeller: UILabel!
    
    @IBAction func deleteListing(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.listingTitle.text = ""
        self.listingPrice.text = ""
        self.listingSeller.text = ""
    }
    

    
}
