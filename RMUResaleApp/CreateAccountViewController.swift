//
//  AccountViewController.swift
//  RMUResaleApp
//
//  Created by Mitchell Keller on 4/13/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit
import CoreData

class AccountViewController: UIViewController, UITextFieldDelegate {
    
    let blankWarning: String = "Fill in All Fields"
    let mismatchPasswordWarning: String = "Passwords do not match"
    
    var items: [NSManagedObject] = []

    @IBOutlet weak var newFirstnameField: UITextField!
    @IBOutlet weak var newLastnameField: UITextField!
    @IBOutlet weak var newEmailField: UITextField!
    @IBOutlet weak var newUsernameField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var accountWarningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.newFirstnameField.delegate = self
        self.newLastnameField.delegate = self
        self.newEmailField.delegate = self
        self.newUsernameField.delegate = self
        self.newPasswordField.delegate = self
        self.confirmPasswordField.delegate = self
        self.accountWarningLabel.text = ""
    }
    

    //Method for dismissing keyboard with return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //This method will work for ALL text fields
    //dismiss keyboard when tapping elsewhere
    @objc func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        self.accountWarningLabel.text = ""
        if(self.newFirstnameField.text == "" ||
            self.newLastnameField.text == "" ||
            self.newEmailField.text == "" ||
            self.newUsernameField.text == "" ||
            self.newPasswordField.text == "" ||
            self.confirmPasswordField.text == "")
        {
            self.accountWarningLabel.text = blankWarning
        }
        else if(self.newPasswordField.text != self.confirmPasswordField.text){
            self.accountWarningLabel.text = mismatchPasswordWarning
            confirmPasswordField.textColor = UIColor.red
        }
            //Only when all the fields have relevent, matching, good data will the button actually save the data. 
        else {
            let firstname = self.newFirstnameField.text!
            let lastname = self.newLastnameField.text!
            let email = self.newEmailField.text!
            let username = self.newUsernameField.text!
            let password = self.newPasswordField.text!
            
            //save new account information to Accounts entity
            self.save(firstname, lastname, email, username, password)
            
            //segue back to login page
            performSegue(withIdentifier: "returnToLogin", sender: sender)
            
        }
    }
    
    //Function to save the new account data into our core data entity: Accounts
    
    func save(_ firstName: String, _ lastName: String, _ email: String, _ username: String, _ password: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Accounts", in: managedContext)!
        
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue(firstName, forKeyPath: "firstName")
        item.setValue(lastName, forKeyPath: "lastName")
        item.setValue(email, forKeyPath: "email")
        item.setValue(username, forKeyPath: "username")
        item.setValue(password, forKeyPath: "password")
        
    }
 
    
}
