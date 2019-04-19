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
    let takenUsernameWarning: String = "Username Already Taken, Try Another"
    let takenEmailWarning: String = "Email Already Used, Try Another"
    
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
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
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
        
        //CHECK: Any empty fields
        if(self.newFirstnameField.text == "" ||
            self.newLastnameField.text == "" ||
            self.newEmailField.text == "" ||
            self.newUsernameField.text == "" ||
            self.newPasswordField.text == "" ||
            self.confirmPasswordField.text == "")
        {
            self.accountWarningLabel.text = blankWarning
        }
            //CHECK: new password == confirmed password.
        else if(self.newPasswordField.text != self.confirmPasswordField.text){
            self.accountWarningLabel.text = mismatchPasswordWarning
            confirmPasswordField.textColor = UIColor.red
        }
            
            //*******SAVE ACCOUNT DATA INTO ACCOUNTS ENTITY*******
            //Only when all the fields have relevent, matching, good data will the button actually save the data.
        else {
            let firstname = self.newFirstnameField.text!
            let lastname = self.newLastnameField.text!
            let email = self.newEmailField.text!
            let username = self.newUsernameField.text!
            let password = self.newPasswordField.text!
            
            //CHECK: username != any other username in database
            if(myFetchRequest(username: username, email: email) == true){
                //save new account information to Accounts entity
                self.save(firstname, lastname, email, username, password)
                
                //segue back to login page
                performSegue(withIdentifier: "returnToLogin", sender: sender)
            }
        }
    }
    
    
    
    //********************       Save Function       *******************
    //     Function to save the new account data into our core data entity: Accounts
    
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
        
        do {
            try managedContext.save()
            items.append(item)
        } catch let error as NSError {
            print("Could not save. \(error). \(error.userInfo)")
        }
        
    }
    
    
    //**************     CHECKING FOR USERNAME OR EMAIL ALREADY TAKEN     *******************
    
    //Function to search Core Data for matching usernames/emails
    func myFetchRequest(username: String, email: String) -> Bool
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let myUsernameRequest = NSFetchRequest<NSManagedObject>(entityName: "Accounts")
        let myEmailRequest = NSFetchRequest<NSManagedObject>(entityName: "Accounts")
        
        myUsernameRequest.predicate = NSPredicate(format: "username = %@", username)
        myEmailRequest.predicate = NSPredicate(format: "email = %@", email)
        
        // BEGIN USERNAME CONFIRMATION
        do{
            let userResults = try managedContext.fetch(myUsernameRequest)
            
            for userResult in userResults
            {
                /* NOTE:
                 If there are results, this for loop will be entered and thus there is already a record with the attempted username
                 If there is no identical username already created, this loop will not even run once
                 */
                
                let usernameCheck = "\(userResult.value(forKey: "username")!)"
                //let passwordCheck = "\(result.value(forKey: "password")!)"
                print("DATABASE RESULT: \(usernameCheck)")
                print("TEXTFIELD ENTRY: \(username)")
                self.accountWarningLabel.text = takenUsernameWarning
                return false
            }
            
        } catch let error{
            print(error)
            return false
        }
        
        // BEGIN EMAIL CONFIRMATION
        do
        {
            let emailResults = try managedContext.fetch(myEmailRequest)
            
            for emailResult in emailResults
            {
                /* NOTE:
                 If there are results, this for loop will be entered and thus there is already a record with the attempted username
                 If there is no identical username already created, this loop will not even run once
                 */
                
                let emailCheck = "\(emailResult.value(forKey: "email")!)"
                print("DATABASE RESULT: \(emailCheck)")
                print("TEXTFIELD ENTRY: \(email)")
                self.accountWarningLabel.text = takenEmailWarning
                return false
            }
        }
        catch let error
        {
            print(error)
            return false
        }
        
        return true
    }
    
    
}
