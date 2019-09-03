//
//  OrdersHistoryVC.swift
//  POS
//
//  Created by Djubo on 31/08/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import UIKit
import Material
import SwiftIcons
import Alamofire

protocol filledCellCommunicator {
    func openViewOrder(order: OrdersResponseModel)
}
class OrdersHistoryVC: UIViewController {
    var toolbar : Toolbar?
    var menuBtn : IconButton?
    @IBOutlet weak var tableView: UITableView!
    
    var page: Int = 1
    var ordersList: [OrdersResponseModel] = []
    let filledCell = "FilledCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        prepareToolbar()
        Utils.showProgress()
        OrderListFetcher()
        
        self.tableView.register(UINib.init(nibName: filledCell, bundle: nil), forCellReuseIdentifier: filledCell)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func prepareToolbar() {
        toolbar = toolbarController?.toolbar
        
        toolbar?.title = "History"
        toolbar?.titleLabel.textColor = .white
        toolbar?.titleLabel.textAlignment = .left
        toolbar?.titleLabel.font = UIFont(name: Constants.fontSemiBoldName, size: 17)
        
        Utils.setStatusBarColor(color: ColorHelper.getThemeOrangeColor())
        toolbar?.backgroundColor = ColorHelper.getThemeOrangeColor()
        
        //set left Button
        setLeftMenuOption()
        
        toolbar?.leftViews = [menuBtn!]
        
    }
    
    func setLeftMenuOption(){
        menuBtn = IconButton(image: UIImage.init(icon: .fontAwesomeSolid(.bars), size: CGSize(width: 25, height: 25), textColor: .white), tintColor: .white)
        menuBtn?.pulseColor = .white
        menuBtn?.addTarget(self, action: #selector(openLeftSliderMenu), for: .touchUpInside)
    }
    
    @objc func openLeftSliderMenu(){
        self.navigationDrawerController?.openLeftView()
        
    }
    
    func OrderListFetcher() {
        if Utils.isInternetAvailable(){
            var payload : [String: AnyObject] = [String: AnyObject]()
            payload["pageId"] = page as AnyObject
            payload["serviceShopId"] =  ApplicationVariables.sharedInstance.selectedOutlet?.id as AnyObject
            payload["searchType"] = 1 as AnyObject
            
            let request = APIRequestHelper.getHisotircalOrders(params: payload)
            Utils.showProgress()
            request.perform(withSuccess: {orders in
                self.ordersList.append(contentsOf: orders)
                Utils.dissmissProgress()
                self.tableView.reloadData()
            }, failure: {error in
                Utils.dissmissProgress()
                
            })
            
            
        } else {
            // show network error toast
        }
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

extension OrdersHistoryVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : FilledCell = tableView.dequeueReusableCell(withIdentifier: filledCell, for: indexPath) as! FilledCell
        cell.configureForHistoryOrder(order: ordersList[indexPath.row])
        if indexPath.row == (ordersList.count-1) {
            page += 1
            OrderListFetcher()
        }
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "POSMain", bundle: nil)
        let dashBoardViewController = storyboard.instantiateViewController(withIdentifier: "ViewOrderVC") as? ViewOrderVC
        dashBoardViewController?.orderObj = ordersList[indexPath.row]
    self.navigationController?.pushViewController(AppToolbarController(rootViewController:dashBoardViewController!), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
}

//extension OrdersHistoryVC: filledCellCommunicator{
//
//    func openViewOrder(order: OrdersResponseModel) {
//        <#code#>
//    }
//
//
//}
