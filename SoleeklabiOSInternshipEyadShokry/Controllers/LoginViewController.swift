//
//  LoginViewController.swift
//  SoleeklabiOSInternshipEyadShokry
//
//  Created by Eyad Shokry on 5/23/19.
//  Copyright © 2019 Eyad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: - Variables Diclaration
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: - Login methods
    fileprivate func goToHomePage() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePage")
        self.present(viewController!, animated: true, completion: nil)
    }
    
    @IBAction func onClickLoginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(user, error) in
            if(error == nil){
                self.goToHomePage()
            }
            else {
                self.showAuthenticationAlert(title: nil, message: error?.localizedDescription)
            }
        }
    }
    
    @IBAction func onClickFacebookLoginButton(_ sender: UIButton) {
    }
    
    @IBAction func onClickGmailLoginButton(_ sender: UIButton) {
    }
    
    @IBAction func onClickResetPasswordButton(_ sender: UIBarButtonItem) {
        let alertControllerWithTextField = UIAlertController(title: "Enter your E-mail", message: "Please, enter your email to send reset password link to it", preferredStyle: .alert)
        alertControllerWithTextField.addTextField(configurationHandler: { (textField: UITextField!) -> Void in
            textField.placeholder = "Enter your Email"
            
        })
        let saveAction = UIAlertAction(title: "Send", style: .default, handler: {alert -> Void in
            let emailTextField = alertControllerWithTextField.textFields![0] as UITextField
            self.resetPassword(email: emailTextField.text!)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertControllerWithTextField.addAction(saveAction)
        alertControllerWithTextField.addAction(cancelAction)
        
        self.present(alertControllerWithTextField, animated: true, completion: nil)
    }
    
    private func resetPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            var title = ""
            var message = ""
            
            if(error != nil) {
                title = "Error!"
                message = (error?.localizedDescription)!
            }
            else {
                title = "Success"
                message = "Password reset email sent"
            }
            
            self.showAuthenticationAlert(title: title, message: message)
        })

    }
}
