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

class SubmitPaymentViewController: UIViewController {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var paymentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let bottomLayer = CALayer()
//        bottomLayer.backgroundColor = FlatGray().lighten(byPercentage: 0.4)?.cgColor
//        bottomLayer.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 2.0)
//        amountTextField.layer.addSublayer(bottomLayer)
        
        view.backgroundColor = HexColor("#e8f4f8")
        
    }
    
    @IBAction func actualSubmitPaymentPressed(_ sender: Any) {
        
        if amountTextField.text?.isEmpty == true || paymentTextField.text?.isEmpty == true {
            let alert = UIAlertController(title: "Error", message: "Please fill in blanks.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            let ref = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("payments")
            ref.childByAutoId().setValue(["amount":amountTextField.text,"paymentID":paymentTextField.text])
            navigationController?.popViewController(animated: true)
        }
        
    }
    

}
