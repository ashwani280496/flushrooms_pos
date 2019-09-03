//
//  FilledCell.swift
//  POS
//
//  Created by Djubo on 05/07/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import UIKit
import Material

class FilledCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var durationTV: UILabel!
    @IBOutlet weak var containerOrOrderNumberLbl: UILabel!
    @IBOutlet weak var roomNumberLbl: UILabel!
    @IBOutlet weak var createdByLbl: UILabel!
    @IBOutlet weak var releaseTableBtn: UIButton!
    @IBOutlet weak var orderStatusIv: UIImageView!
    @IBOutlet weak var amountLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        containerView.cornerRadiusPreset = CornerRadiusPreset(rawValue: 1)!
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureForHistoryOrder(order: OrdersResponseModel){
        containerOrOrderNumberLbl.text = "Order # \(order.orderNumber)"
        if let room_Number = order.roomNumber {
            roomNumberLbl.text = "Pushed to room No: \(room_Number)"
        } else {
            roomNumberLbl.text = ""
        }
        guard let staffs = ApplicationVariables.sharedInstance.staffList else { return  }
        for staff in staffs {
            if order.createdBy == staff.id {
                createdByLbl.text = staff.first_name
            }
        }
        
        orderStatusIv.image = Utils.orderStatusIconProvider(status: order.status)
        
        let dateString = DateHelper.dateToStringGenerator(date: DateHelper.stringToDateGenerator(dateStr: order.createdAt, format: DateHelper.serverDateTimeFormat), format: DateHelper.historyDisplayDateFormat)
        durationTV.text = dateString
        
        amountLbl.text = String(getOrderGrossAmount(order:order))
        
        releaseTableBtn.isHidden = true
        
    }
    
    func getOrderGrossAmount(order: OrdersResponseModel)-> Double {
        
        var totalNetPrice: Double = 0
        var totalTax: Double = 0
        var discount: Double = 0
        
        if let orderItems = order.orderItems{
            for orderItem in orderItems.orderItems{
                if (!orderItem.isComplementary){
                    totalNetPrice += (orderItem.unitPrice * Double(orderItem.quantity))
                    totalTax = 10
                    discount += orderItem.discounts
                    
                }
            }
        }
        
        return totalTax + totalNetPrice - discount
    }
    
}
