//
//  SettingsViewController.swift
//  Shopee
//
//  Created by Wu Peirong on 21/10/18.
//  Copyright © 2018 Wu Peirong. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SettingsViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    let ref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if emailTextField.text?.isEmpty == true || addressTextField.text?.isEmpty == true || phoneTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Error", message: "Please fill in the blanks.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            } else {
            ref.child("users/\(uid!)/email").setValue(emailTextField.text!)
            ref.child("users/\(uid!)/address").setValue(addressTextField.text!)
            ref.child("users/\(uid!)/phone").setValue(phoneTextField.text!)
        }
    }
    

}
