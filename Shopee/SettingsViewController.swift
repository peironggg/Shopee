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
import JGProgressHUD

class SettingsViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    let ref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()

        ref.child("users").child(uid!).observe(.value) { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            print(postDict)
            if let email = postDict["email"] {
                self.emailTextField.text = email as? String
            }
            if let address = postDict["address"] {
                self.addressTextField.text = address as? String
            }
            if let phone = postDict["phone"] {
                self.phoneTextField.text = phone as? String
            }

        }
        
    }
    

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if emailTextField.text?.isEmpty == true || addressTextField.text?.isEmpty == true || phoneTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Error", message: "Please fill in the blanks.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            } else {
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Success"
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.show(in: self.view)
            ref.child("users/\(uid!)/email").setValue(emailTextField.text!)
            ref.child("users/\(uid!)/address").setValue(addressTextField.text!)
            ref.child("users/\(uid!)/phone").setValue(phoneTextField.text!)
            hud.dismiss()
        }
    }
    

}
