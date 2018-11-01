//
//  OrdersViewController.swift
//  Shopee
//
//  Created by Wu Peirong on 21/10/18.
//  Copyright © 2018 Wu Peirong. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SwipeCellKit

class OrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {

    

    @IBOutlet weak var ordersTableView: UITableView!
    var pendingArray: [[String]] = []
    var confirmedArray: [[String]] = []
    var deliveryArray: [[String]] = []
    var cellArray: [[String]] = []
    var pickerCountry: [String] = []
    


    let uid = Auth.auth().currentUser?.uid
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
        ref.child("users").child(uid!).child("orders").observe(.value) { (snapshot) in
            self.pendingArray = []
            self.confirmedArray = []
            self.deliveryArray = []
            print("snapshot retrieved")
            for orders in snapshot.children.allObjects {
                let id = orders as! DataSnapshot
                print("ID: \(id.key)")
                let values = id.value as? NSDictionary
                print(values as Any)

                let payment = values?["payment"] as? Bool
                let delivery = values?["delivery"] as? Bool
                self.pickerCountry.append((values?["country"] as? String)!)
                
                print("Status: \(payment)")

                if payment == false && delivery == false {
                    let order = [values!["url"],values!["price"],values!["quantity"],values!["remarks"],id.key]
                    self.pendingArray.append(order as! [String])

                } else if payment == true && delivery == false {
                    let order = [values!["url"],values!["price"],values!["quantity"],values!["remarks"],id.key]
                    self.confirmedArray.append(order as! [String])

                } else if payment == true && delivery == true {
                    let order = [values!["url"],values!["price"],values!["quantity"],values!["remarks"],id.key]
                    self.deliveryArray.append(order as! [String])
                }
            }
            print(self.pendingArray.count)
            print(self.confirmedArray.count)
            self.cellArray = self.pendingArray
            self.ordersTableView.reloadData()
        }
        ordersTableView.delegate = self
        ordersTableView.dataSource = self

        let nib = UINib(nibName: "OrderCell", bundle: nil)
        ordersTableView.register(nib, forCellReuseIdentifier: "orderCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCell
        cell.delegate = self
        
        if cellArray.isEmpty {
            cell.urlLabel.text = ""
            cell.priceLabel.text = ""
            cell.quantityLabel.text = ""
            cell.remarksLabel.text = ""

        } else {
            cell.urlLabel.text = "url: \(cellArray[indexPath.row][0])"
            if pickerCountry[indexPath.row] == "China" {
                let price = Double(cellArray[indexPath.row][1])!/4.7
                let quantity = Double(cellArray[indexPath.row][2])!
                let totalPrice = price*quantity
                let roundedPrice = String(format: "%.2f", totalPrice)
                cell.priceLabel.text = "Please Pay: \(roundedPrice)"
            } else if pickerCountry[indexPath.row] == "USA" {
                let priceUS = Double(cellArray[indexPath.row][1])!*1.4
                let quantity = Double(cellArray[indexPath.row][2])!
                let totalPriceUS = priceUS*quantity
                let roundedPriceUS = String(format: "%.2f", totalPriceUS)
                cell.priceLabel.text = "Please Pay: \(roundedPriceUS)"
            }
            cell.quantityLabel.text = "Quantity: \(cellArray[indexPath.row][2])"
            cell.remarksLabel.text = "Remarks: \(cellArray[indexPath.row][3])"
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            let id = self.cellArray[indexPath.row][4]
            self.ref.child("users").child(self.uid!).child("orders").child(id).removeValue()
            action.fulfill(with: .delete)
        }
        ordersTableView.reloadData()
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 171
    }
    @IBAction func ordersSegmentedPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            cellArray = confirmedArray
            ordersTableView.reloadData()
        } else if sender.selectedSegmentIndex == 0 {
            cellArray = pendingArray
            ordersTableView.reloadData()
        } else if sender.selectedSegmentIndex == 2 {
            cellArray = deliveryArray
            ordersTableView.reloadData()
        }
    }



}
