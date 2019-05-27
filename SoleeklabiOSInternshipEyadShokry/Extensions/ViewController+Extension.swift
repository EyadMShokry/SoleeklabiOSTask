//
//  ViewController+Extension.swift
//  SoleeklabiOSInternshipEyadShokry
//
//  Created by Eyad Shokry on 5/23/19.
//  Copyright © 2019 Eyad. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAuthenticationAlert(title: String? = "Error", message: String? = "Error") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
}
