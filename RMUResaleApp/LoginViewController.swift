//
//  LoginViewController.swift
//  RMUResaleApp
//
//  Created by Mitchell Keller on 4/3/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let wrongUsername: String = "Invalid Username"
    let wrongPassword: String = "Invalid Password"
    let blankFields: String = "Enter Username and Password"
    //textField outlets
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.passwordField.delegate = self
        self.usernameField.delegate = self
        self.warningLabel.text = " "
        
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
    

    @IBAction func loginButton(_ sender: Any) {
        if(self.passwordField.text == "" || self.usernameField.text == "") {
            self.warningLabel.text = blankFields
        }
        else{
            performSegue(withIdentifier: "loginSegue", sender: sender)
        }
    }
    @IBAction func unwindToVC(segue: UIStoryboardSegue){
        
    }
    
}

