//
//  LoginViewController.swift
//  RMUResaleApp
//
//  Created by Mitchell Keller on 4/3/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var items: [NSManagedObject] = []
    let wrongUsername: String = "Invalid Username"
    let wrongPassword: String = "Invalid Password"
    let blankFields: String = "Enter Username and Password"
    //textField outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    
    
    //****************     viewDidLoad     *************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.passwordField.delegate = self
        self.usernameField.delegate = self
        self.warningLabel.text = " "
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print("HERE:")
        print(paths[0])
        
        let URL = NSPersistentContainer.defaultDirectoryURL()
        print("URL: \(URL)")

    }
    
    
    
    
    //*************      Required Keyboard Function     ****************
    
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
    
    
    
    
    
    
    //*************     LOGIN BUTTON ACTION     *************
    
    @IBAction func loginButton(_ sender: Any) {

        if(self.passwordField.text == "" || self.usernameField.text == "") {
            self.warningLabel.text = blankFields
        }
        else {
            let username = self.usernameField.text!
            let password = self.passwordField.text!
            if(myFetchRequest(username: username, password: password) == true){
                print("It's true")
                performSegue(withIdentifier: "loginSegue", sender: sender)
            }
            else{
                self.warningLabel.text = wrongUsername
            }
        }
    }
    
    
    
    
    
    

    //**************     CHECKING FOR USERNAME/PASSWORD MATCH     *******************
    
    //Function to search Core Data for matching usernames
    func myFetchRequest(username: String, password: String) -> Bool
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let myRequest = NSFetchRequest<NSManagedObject>(entityName: "Accounts")
        
        myRequest.predicate = NSPredicate(format: "username = %@", username)
        
        do{
            let results = try managedContext.fetch(myRequest)
            
            for result in results
            {
                let usernameCheck = "\(result.value(forKey: "username")!)"
                let passwordCheck = "\(result.value(forKey: "password")!)"
                //let passwordCheck = "\(result.value(forKey: "password")!)"
                if (username == usernameCheck && password == passwordCheck){
                    Username.userMaster = username
                    return true
                }
                else{
                    return false
                }
            }
            
        } catch let error{
            print(error)
            return false
        }
        return false
    }
}

struct Username{
    static var userMaster = ""
}

