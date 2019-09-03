//
//  OrderSummaryCell.swift
//  POS
//
//  Created by Djubo on 01/09/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import UIKit
import SwiftIcons

class OrderSummaryCell: UITableViewCell {
   
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var netAmountLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var paymentsLbl: UILabel!

    
    @IBOutlet weak var taxIconBtn: UIButton!
    @IBOutlet weak var paymentIconBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        taxIconBtn.setIcon(icon: .fontAwesomeSolid(.infoCircle), forState: .normal)
        paymentIconBtn.setIcon(icon: .fontAwesomeSolid(.bars), forState: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func paymentIconClick(_ sender: Any) {
    }
    
    @IBAction func taxInconClick(_ sender: Any) {
    }
}
