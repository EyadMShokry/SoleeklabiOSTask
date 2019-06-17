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
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    // MARK: - Variables Diclaration
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: - Login methods
    fileprivate func goToHomePage() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LittersController")
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
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                    if let error = error {
                        print("Login error: \(error.localizedDescription)")
                        self.showAuthenticationAlert(title: "Login Error", message: error.localizedDescription)
                        return
                    }
                
                    // Present the main view
                    if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePage") {
                        self.present(viewController, animated: true)
                    }
                
            })
                
        }
    }
    
    @IBAction func onClickGmailLoginButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    @IBAction func onClickResetPasswordButton(_ sender: UIBarButtonItem) {
        createAlertControllerWithTextField()
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
    
    fileprivate func createAlertControllerWithTextField() {
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
}


extension LoginViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = "103681726110-jdnjs5hs75vbigstvq55ads1g6n1ml2l.apps.googleusercontent.com"

        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/userinfo.email")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/userinfo.profile")
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Google Sign In DidSignInForUser")
        if let error = error {
            self.showAuthenticationAlert(title: "Login Error", message: error.localizedDescription)

            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
        
        // When user is signed in
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if let error = error {
                self.showAuthenticationAlert(title: "Login Error", message: error.localizedDescription)
                return
            }
            
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomePage") {
                self.present(viewController, animated: true)
            }
            
        })
    }
    
}
