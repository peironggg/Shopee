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

class OrdersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var ordersTableView: UITableView!
    var pendingArray: [[String]] = []
    var confirmedArray: [[String]] = []
    var deliveryArray: [[String]] = []
    var cellArray: [[String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
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
                
                print("Status: \(payment)")

                if payment == false && delivery == false {
                    let order = [values!["url"],values!["price"],values!["quantity"],values!["remarks"]]
                    self.pendingArray.append(order as! [String])

                } else if payment == true && delivery == false {
                    let order = [values!["url"],values!["price"],values!["quantity"],values!["remarks"]]
                    self.confirmedArray.append(order as! [String])

                } else if payment == true && delivery == true {
                    let order = [values!["url"],values!["price"],values!["quantity"],values!["remarks"]]
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
        if cellArray.isEmpty {
            cell.urlLabel.text = ""
            cell.priceLabel.text = ""
            cell.quantityLabel.text = ""
            cell.remarksLabel.text = ""

        } else {
            cell.urlLabel.text = "url: \(cellArray[indexPath.row][0])"
            cell.priceLabel.text = "Price: \(cellArray[indexPath.row][1])"
            cell.quantityLabel.text = "Quantity: \(cellArray[indexPath.row][2])"
            cell.remarksLabel.text = "Remarks: \(cellArray[indexPath.row][3])"
        }
        return cell
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
