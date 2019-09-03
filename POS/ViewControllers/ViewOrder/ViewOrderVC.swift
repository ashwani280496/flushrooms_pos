//
//  ViewOrderVC.swift
//  POS
//
//  Created by Djubo on 01/09/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import UIKit
import Material
import SwiftIcons

class ViewOrderVC: UIViewController {
    
    var toolbar : Toolbar?
    var menuBtn : IconButton?
    var statusIV : UIImageView?
    
    var orderObj : OrdersResponseModel!
    @IBOutlet weak var orderPlacedonPlaceHolderLbl: UILabel!
    @IBOutlet weak var tableOrRoomNumLbl: UILabel!
    @IBOutlet weak var servedByLbl: UILabel!
    @IBOutlet weak var createdDateLbl: UILabel!
    @IBOutlet weak var settlementModelLbl: UILabel!
    @IBOutlet weak var deliveryDateLbl: UILabel!
    @IBOutlet weak var calendarIV: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    let summaryCell = "OrderSummaryCell"
    let itemCell = "ItemViewCell"


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareToolbar()
        setValuesforHeader()
        self.tableView.register(UINib.init(nibName: summaryCell, bundle: nil), forCellReuseIdentifier: summaryCell)
        self.tableView.register(UINib.init(nibName: itemCell, bundle: nil), forCellReuseIdentifier: itemCell)
        tableView.delegate = self
        tableView.dataSource = self
        // setNav()
        
        //self.navigationController?.navigationBar.isHidden = false
        
        // Do any additional setup after loading the view.
    }
    
    func setNav(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = ColorHelper.getThemeOrangeColor()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func prepareToolbar() {
        toolbar = toolbarController?.toolbar
        toolbar?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
        
        toolbar?.title = String("Order # \(orderObj.orderNumber)")
        toolbar?.titleLabel.textColor = Color.white
        toolbar?.titleLabel.textAlignment = .center
        toolbar?.titleLabel.font = UIFont(name: Constants.fontSemiBoldName, size: 20)
        
        Utils.setStatusBarColor(color: ColorHelper.getThemeOrangeColor())
        toolbar?.backgroundColor = ColorHelper.getThemeOrangeColor()
        
        //set left Button
        setLeftMenuOption()
        
        let image =  Utils.orderStatusIconProvider(status: orderObj.status)
        statusIV = UIImageView(image: image)
        statusIV!.frame = CGRect(x: -20, y: 5, width: 50 , height: 50)
        
        let v = UIView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        v.addSubview(statusIV!)
        
        toolbar?.leftViews = [menuBtn!]
        toolbar?.rightViews = [v]
        
    }
    
    func setLeftMenuOption(){
        menuBtn = IconButton(image: UIImage.init(icon: .fontAwesomeSolid(.arrowLeft), size: CGSize(width: 25, height: 25), textColor: .white), tintColor: .white)
        menuBtn?.pulseColor = .white
        menuBtn?.addTarget(self, action: #selector(openLeftSliderMenu), for: .touchUpInside)
    }
    
    @objc func openLeftSliderMenu(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func setValuesforHeader() {
        let staff = ApplicationVariables.sharedInstance.staffList
        if orderObj.linkToRoom {
            orderPlacedonPlaceHolderLbl.text = "Room "
            tableOrRoomNumLbl.text = orderObj.roomNumber
        } else if orderObj.serviceDisplayContainerId != nil {
            orderPlacedonPlaceHolderLbl.text = "Table No. "
            //tableOrRoomNumLbl.text = orderObj.roomNumber
        } else {
            orderPlacedonPlaceHolderLbl.text = "Takeaway "
            tableOrRoomNumLbl.isHidden = true
        }
        
        for staff in staff!{
            if staff.id == orderObj.createdBy {
                servedByLbl.text = staff.first_name
            }
        }
        
        let dateString = DateHelper.dateToStringGenerator(date: DateHelper.stringToDateGenerator(dateStr: orderObj.createdAt, format: DateHelper.serverDateTimeFormat), format: DateHelper.historyDisplayDateFormat)
        createdDateLbl.text = dateString
        
        if OrderStatusEnum(rawValue: orderObj.status) == OrderStatusEnum.OS_SETTLE {
            if orderObj.linkToRoom && orderObj.roomNumber != nil && !orderObj.isComplementary!{
                settlementModelLbl.text = String("Push to Room \(orderObj.roomNumber!)")
            } else if orderObj.isComplementary!{
                settlementModelLbl.text = "Complementary"
            } else {
                if orderObj.payments != nil && orderObj.payments!.count>0 && orderObj.roomNumber != nil{
                    settlementModelLbl.text = "Multiple Payments"
                } else if orderObj.payments != nil && orderObj.payments?.count == 1 {
                    if let payment = orderObj.payments{
                        if payment[0].mode == PaymentTypeEnum.CASH.rawValue{
                            settlementModelLbl.text = "Cash"
                            
                        }else if payment[0].mode == PaymentTypeEnum.E_COLLECT.rawValue{
                            settlementModelLbl.text = "E-Collect"
                            
                        }else {
                            settlementModelLbl.text = "Card"
                            
                        }
                    }
                }
            }
        } else if OrderStatusEnum(rawValue: orderObj.status) == OrderStatusEnum.OS_CANCEL && orderObj.isComplementary!{
            settlementModelLbl.text = "Complementary"
            
        } else {
            settlementModelLbl.text = "--"
            
        }
        
        let dateString1 = DateHelper.dateToStringGenerator(date: DateHelper.stringToDateGenerator(dateStr: orderObj.date, format: DateHelper.defaultDateFormat), format: DateHelper.ddMMyyyyFormat)
        deliveryDateLbl.text = dateString1
        
        calendarIV.image = UIImage.init(icon: .googleMaterialDesign(.permContactCalendar), size: CGSize(width: 25, height: 25))
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ViewOrderVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : ItemViewCell = tableView.dequeueReusableCell(withIdentifier: itemCell, for: indexPath) as! ItemViewCell
            cell.hideshowConstant.constant = 0.0
            //        cell.configureForHistoryOrder(order: ordersList[indexPath.row])
            //        if indexPath.row == (ordersList.count-1) {
            //            page += 1
            //            OrderListFetcher()
            //        }
            return cell
        } else {
            let cell : OrderSummaryCell = tableView.dequeueReusableCell(withIdentifier: summaryCell, for: indexPath) as! OrderSummaryCell
            //        cell.configureForHistoryOrder(order: ordersList[indexPath.row])
            //        if indexPath.row == (ordersList.count-1) {
            //            page += 1
            //            OrderListFetcher()
            //        }
            return cell
        }
        }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        } else {
            return 135
        }
    }
}
