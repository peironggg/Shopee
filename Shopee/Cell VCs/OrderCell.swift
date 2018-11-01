//
//  OrderCell.swift
//  Shopee
//
//  Created by Wu Peirong on 23/10/18.
//  Copyright © 2018 Wu Peirong. All rights reserved.
//

import UIKit
import SwipeCellKit

class OrderCell: SwipeTableViewCell {

    
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var remarksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
