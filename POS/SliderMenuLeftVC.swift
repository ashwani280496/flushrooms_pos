//
//  SliderMenuLeftVC.swift
//  POS
//
//  Created by Ashwani Kumar on 02/07/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

// it is for left navigation Items

import Foundation
import UIKit
import DropDown
import Material
import Popover
import SwiftIcons

class SliderMenuLeftVC : UIViewController{
    
    var mainViewController: UIViewController!
    
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var delegate: HomeControllerDelegate?
    
    var dropDown : DropDown?
    let sliderMenuTableCellIdentifier = "SliderMenuTableViewCell"
    var sliderMenuOptions : [String] = [String]()
    //var iconsArray : [String] = [FontAwesome]()
    var popover: Popover!
    var popoverOptions: [PopoverOption] = [
        .type(.down),.animationIn(0.8),
        .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    
    override func viewDidLoad() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapToOpenPropertyDropDown(_:)))
        dropdownView.addGestureRecognizer(tapGesture)
        
        self.tableView.register(UINib.init(nibName: "SliderMenuTableViewCell", bundle: nil), forCellReuseIdentifier: sliderMenuTableCellIdentifier)
        
        setsliderMenuOptions()
        navigationController?.navigationBar.barTintColor = ColorHelper.getThemeOrangeColor()
        navigationController?.navigationBar.barStyle = .black
    }
    
    func setsliderMenuOptions(){
        
        sliderMenuOptions.append("POS")
        sliderMenuOptions.append("History")
        sliderMenuOptions.append("CRS")
        sliderMenuOptions.append("Printer Settings")
        sliderMenuOptions.append("Logout")
        sliderMenuOptions.append("Feedback")
        sliderMenuOptions.append("Call us for help")
        
//        iconsArray.append("")
//        iconsArray.append("")
//        iconsArray.append("")
//        iconsArray.append("")
//        iconsArray.append("")
//        iconsArray.append("")
//        iconsArray.append("")
    }
    
    func setPropertyDropDown(){
        dropDown = DropDown()
        dropDown?.anchorView = dropdownView
        
        var propertyNameArray = [String]()

        for property in ApplicationVariables.sharedInstance.properties!{
            propertyNameArray.append(property.name!)
        }
        
        dropDown?.dataSource = propertyNameArray
        
        dropDown?.selectionAction = { [unowned self] (index, item) in
            self.propertyNameLabel.text = item
            ApplicationVariables.sharedInstance.selectedProperty = ApplicationVariables.sharedInstance.properties![index]
//            UserDefaultsHelper.saveIntPreferences(key: UserDefaultKeys.propertyId, value: (ApplicationVariables.sharedInstance.selectedProperty?.id)!)
            self.changePropertyForViewController()
        }
        
        propertyNameLabel.text = ApplicationVariables.sharedInstance.selectedProperty?.name
    }
    
    @objc func tapToOpenPropertyDropDown(_ sender: UITapGestureRecognizer) {
        print("Please Help!")
        
        dropDown?.show()
    }
    
    func changePropertyForViewController(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.showHomeScreen()
    }
    
    @objc func closeFeedBackpopup() {
        self.popover.dismiss()
    }
    
    @objc func hideKeyboard() {
        
    }
}


extension SliderMenuLeftVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sliderMenuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SliderMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SliderMenuTableViewCell") as! SliderMenuTableViewCell
        cell.menuOptionLabel.text = sliderMenuOptions[indexPath.row]
        //        cell.menuOptionIcon.image = Utils.getFontIcon(icon: iconsArray[indexPath.row],color: .white)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if sliderMenuOptions[indexPath.row] == "POS"{
            appDelegate.showHomeScreen()
            
        }else if sliderMenuOptions[indexPath.row] == "History"{
            
            let storyboard = UIStoryboard(name: "POSMain", bundle: nil)
            let dashBoardViewController = storyboard.instantiateViewController(withIdentifier: "OrdersHistoryVC") as? OrdersHistoryVC
            
            appDelegate.navigateToViewController(viewController: dashBoardViewController!,self1: self)
    }
}
}
