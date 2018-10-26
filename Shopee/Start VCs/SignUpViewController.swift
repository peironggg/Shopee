//
//  RegisterViewController.swift
//  Shopee
//
//  Created by Wu Peirong on 21/10/18.
//  Copyright © 2018 Wu Peirong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import ChameleonFramework

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reenterPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Register"
        
        emailTextField.backgroundColor = FlatBlack().lighten(byPercentage: 0.80)
        emailTextField.textColor = FlatBlack()
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: FlatBlack().lighten(byPercentage: 0.60)!])
        
        passwordTextField.backgroundColor = FlatBlack().lighten(byPercentage: 0.80)
        passwordTextField.textColor = FlatBlack()
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: FlatBlack().lighten(byPercentage: 0.60)!])
   
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            
            if self.passwordTextField.text == self.reenterPasswordTextField.text {
            if error != nil {
                
                let errorMessage = error?.localizedDescription
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                print("Registration Successful")
                let ref = Database.database().reference()
                let usersReference = ref.child("users")
                let uid = Auth.auth().currentUser?.uid
                let newUserReference = usersReference.child(uid!)
                newUserReference.setValue(["email": self.emailTextField.text!])
                print(newUserReference.description())
                
                self.performSegue(withIdentifier: "registerGoToTabBar", sender: self)
            }
            } else {
                let alert = UIAlertController(title: "Error", message: "Passwords do not match.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
  
}
