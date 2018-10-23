//
//  SubmitOrderViewController.swift
//  Shopee
//
//  Created by Wu Peirong on 22/10/18.
//  Copyright © 2018 Wu Peirong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import ChameleonFramework

class SubmitOrderViewController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var remarksTextField: UITextField!
    


    override func viewDidLoad() {
        super.viewDidLoad()

              view.backgroundColor = HexColor("#e8f4f8")

    }
    

    
    @IBAction func submitOrderPressed(_ sender: Any) {
        
        if urlTextField.text?.isEmpty == false && priceTextField.text?.isEmpty == false && quantityTextField.text?.isEmpty == false && remarksTextField.text?.isEmpty == false {
        let ref = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("orders").childByAutoId()
    ref.setValue(["url":urlTextField.text!,"price":priceTextField.text!,"quantity":quantityTextField.text!,"remarks":remarksTextField.text!,"status":false])
        navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill in the blanks.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
