//
//  RegistrationViewController.swift
//  SoleeklabiOSInternshipEyadShokry
//
//  Created by Eyad Shokry on 5/23/19.
//  Copyright © 2019 Eyad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    // MARK: - Registeration Methods
    fileprivate func signup() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error == nil {
                print("Signup successfull")
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePage")
                self.present(viewController!, animated: true, completion: nil)
            }
            else {
                self.showAuthenticationAlert(title: nil, message: error?.localizedDescription)
            }
        }
    }
    
    @IBAction func onClickRegisterButton(_ sender: Any) {
        if (emailTextField.text == "" || passwordTextField.text == "" || confirmPasswordTextField.text == ""){
            self.showAuthenticationAlert(title: nil, message: "Please enter your email and password!")
        }
        else if (passwordTextField.text != confirmPasswordTextField.text) {
            self.showAuthenticationAlert(title: nil, message: "Password doesn't match!")
            
        }
        else {
            signup()
        }
    }
    
    

}
