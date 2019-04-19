//
//  EditAccountViewController.swift
//  RMUResaleApp
//
//  Created by user152037 on 4/17/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit
import CoreData

class EditAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var changedPasswordLabel: UITextField!
    @IBOutlet weak var changeEmailLabel: UITextField!
    
    var edits: [NSManagedObject] = []
    
    
    
    //set up constants for Invalid Entry alerts
    let invalidPasswordAlert = UIAlertController(title: "Invalid Credentials", message: "Please enter a valid password", preferredStyle: .alert)
    let invalidEmailAlert = UIAlertController(title: "Invalid Credentials", message: "Please enter a valid email address", preferredStyle: .alert)
    let closeAlertAction = UIAlertAction(title: "Close", style: .default)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.changeEmailLabel.delegate = self
        self.changedPasswordLabel.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    
    
    
    
    @IBAction func saveChanges(_ sender: Any) {
        invalidPasswordAlert.addAction(closeAlertAction)
        invalidEmailAlert.addAction(closeAlertAction)
        
        if (self.changedPasswordLabel.text == "")
        {
            present(invalidPasswordAlert, animated: true)
        }
        else if (self.changeEmailLabel.text == "")
        {
            present(invalidEmailAlert, animated: true)
        }
        else
        {
            let changedPassword = self.changedPasswordLabel.text!
            let changedEmail = self.changeEmailLabel.text!
            
            save(changedPassword, changedEmail)
            performSegue(withIdentifier: "EditComplete", sender: sender)
        }
    }
    

    func save(_ changedPassword: String, _ changedEmail: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Accounts", in: managedContext)!
        let account = NSManagedObject(entity: entity, insertInto: managedContext)
        
        account.setValue(changedPassword, forKeyPath: "password")
        account.setValue(changedEmail, forKeyPath: "email")
        
        do{
            try managedContext.save()
            edits.append(account)
        }
        catch let error as NSError {
            print("Could not save. \(error). \(error.userInfo)")
        }
    }
    
    
    
}
