//
//  ResultsViewController.swift
//  RMUResaleApp
//
//  Created by Jacob Wright on 4/19/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit
import CoreData
import MessageUI

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!
    
    var sellerInfo: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = ResultsData.titleData
        self.priceLabel.text = "$" + "\(ResultsData.priceData)"
        self.sellerLabel.text = ResultsData.sellerData
        
    }
    
    func fetchEmail (_ seller: String)
    {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let managedContext = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Accounts")
        fetchRequest.predicate = NSPredicate(format: "username = %@", seller)
        
        do {
            sellerInfo = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    @IBAction func contactSeller(_ sender: Any) {
        let seller = ResultsData.sellerData
        fetchEmail(seller)
       
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mail.setToRecipients([sellerInfo[0].value(forKey: "email") as! String])
            mail.setMessageBody("<p> Hello my name is \(Username.userMaster), I am interest in " +
            "purchasing your listing.", isHTML: true)
            
            present(mail, animated: true)
        }
        else
        {
            print("Could not send email")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true)
    }
    
    
    
    
    }
    

