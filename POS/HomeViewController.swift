//
//  HomeViewController.swift
//  POS
//
//  Created by Ashwani Kumar on 02/07/19.
//  Copyright © 2019 Djubo. All rights reserved.
//
import UIKit
import SwiftIcons
import MXSegmentedPager
import Material

class HomeController: MXSegmentedPagerController {
    
    // MARK: - Properties
    var restrauntVC : RestrauntVC?
    var roomsVC : RoomOrderVC?
    
    var delegate: HomeControllerDelegate?
    var subServicesNamesArray : [String] = []
    var viewController :UIViewController?
    var outlets :[OutletModel]?
    var selectedOutlet: OutletModel?
    var bar:UIBarButtonItem?
    var restrauntDeliveriy : DeliveriesModel?
    var roomDelivery : DeliveriesModel?


    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedOutlet = ApplicationVariables.sharedInstance.selectedOutlet
        setContent()
        getOrders()
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        configureNavigationBar()
        viewController=UIViewController.init()
        segmentedPager.backgroundColor = .white
        segmentedPager.backgroundColor = UIColor.white
        segmentedPager.bounces = false
        segmentedPager.segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.fixed
        segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.down
        segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyle.arrow
        //        segmentedPager.segmentedControl.frame = CGRect.init(x: 60, y: 0, width: self.view.bounds.width - 60, height: 40)
        segmentedPager.segmentedControl.backgroundColor = UIColor.black
        
        segmentedPager.segmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font : Font.systemFont(ofSize: 15)]
        segmentedPager.segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        segmentedPager.segmentedControl.selectionIndicatorColor = UIColor.white
        segmentedPager.segmentedControlEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        intializeChildViewController()
    }
    
    func intializeChildViewController(){
        let storyboard = UIStoryboard(name: Constants.posMainStoryboard, bundle: nil)
        
        restrauntVC = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifiers.restrauntVC) as? RestrauntVC
        roomsVC = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifiers.roomsVC) as? RoomOrderVC
    }
    
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return subServicesNamesArray[index].uppercased()
        
    }
    
    override func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
        return subServicesNamesArray.count
    }
    
    override func segmentedPager(_ segmentedPager: MXSegmentedPager, viewControllerForPageAt index: Int) -> UIViewController {
        switch index {
        case 0:
            restrauntVC!.selectedOutlet = selectedOutlet
            return restrauntVC!
        case 1:
            if roomDelivery != nil{
                restrauntVC!.selectedOutlet = selectedOutlet
                roomsVC?.delivery = roomDelivery
                return roomsVC!
            } else{
                return UIViewController()
            }
        case 2:
            return UIViewController()
        case 3:
            return UIViewController()
        case 4:
            return UIViewController()
        case 5:
            return UIViewController()
        case 6:
            return UIViewController()
        case 7:
            return UIViewController()
        default:
            return restrauntVC!
        }    }
    
    // MARK: - Handlers
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = ColorHelper.getThemeOrangeColor()
        navigationController?.navigationBar.barStyle = .black
        
        let barButton  = UIBarButtonItem(image: UIImage.init(icon: .fontAwesomeSolid(.bars), size: CGSize(width: 25, height: 25), textColor: .white)
, style: .plain, target: self, action: #selector(handleMenuToggle))
        barButton.tintColor = .white
        
        let rightBarButton  = UIBarButtonItem(image: UIImage.init(icon: .fontAwesomeSolid(.syncAlt), size: CGSize(width: 25, height: 25), textColor: .white)
            , style: .plain, target: self, action: #selector(handleMenuToggle))
        rightBarButton.tintColor = .white
        bar = UIBarButtonItem.init(title: selectedOutlet?.displayName, style: .plain, target: nil, action: nil)
        bar!.tintColor = .white
        
        
        navigationItem.leftBarButtonItems = [barButton,bar] as! [UIBarButtonItem]
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setContent(){
        for delivery in selectedOutlet!.deliveries {
            subServicesNamesArray.append(delivery.displayName)
            if delivery.isRoomContainer {
                roomDelivery = delivery
            } else if delivery.isContainerDisplay {
                restrauntDeliveriy = delivery
            }
        }
        subServicesNamesArray.append("All Orders")
    }
}

extension HomeController {
    func getOrders() {
        var payload: [String:AnyObject] = [String:AnyObject]()
        payload["serviceShopId"] = selectedOutlet?.id as AnyObject?
        payload["status"] = 3 as AnyObject
        Utils.showProgress()
        let request = APIRequestHelper.getOrders(params: payload)
        request.perform(withSuccess: {orders in
            Utils.dissmissProgress()
//            self.outlets = outletData.outlets
//            for outlet in self.outlets! {
//                if outlet.propertyId == ApplicationVariables.sharedInstance.selectedProperty?.id {
//                    self.selectedOutlet = outlet
//                    self.bar?.title = outlet.displayName
//                    break
//                }
//            }

        }, failure: {error in
            Utils.dissmissProgress()

        })
    }
}
