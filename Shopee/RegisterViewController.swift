//
//  RegisterViewController.swift
//  Shopee
//
//  Created by Wu Peirong on 21/10/18.
//  Copyright © 2018 Wu Peirong. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            
            if error != nil {
                
                let errorMessage = error?.localizedDescription
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                print("Registration Successful")
            }
        }
    }
    
    
  
}
