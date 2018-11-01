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
import JGProgressHUD

class SubmitOrderViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var remarksTextField: UITextField!
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    var pickerData: [String] = [String]()
    var pickerCountry: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = HexColor("#e8f4f8")
        pickerData = ["USA", "China"]
        submitButton.backgroundColor = FlatOrange()
        submitButton.setTitleColor(FlatWhite(), for: .normal)
        submitButton.titleLabel?.font = UIFont(name: "Roboto", size: 20)
        
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        toolBar.setItems([flexibleSpace,doneButton], animated: true)
        urlTextField.inputAccessoryView = toolBar
        priceTextField.inputAccessoryView = toolBar
        quantityTextField.inputAccessoryView = toolBar
        remarksTextField.inputAccessoryView = toolBar
        

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerCountry = pickerData[row]
    }
    
    @IBAction func submitOrderPressed(_ sender: Any) {
        
        if urlTextField.text?.isEmpty == false && priceTextField.text?.isEmpty == false && quantityTextField.text?.isEmpty == false && remarksTextField.text?.isEmpty == false {
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Success"
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.show(in: self.view)
        let ref = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("orders").childByAutoId()
            ref.setValue(["url":urlTextField.text!,"price":priceTextField.text!,"quantity":quantityTextField.text!,"remarks":remarksTextField.text!,"payment":false,"delivery":false,"country":pickerCountry])
            hud.dismiss()
        navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill in the blanks.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
