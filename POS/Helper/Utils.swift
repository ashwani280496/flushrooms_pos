//
//  Utils.swift
//  POS
//
//  Created by Ashwani Kumar on 30/06/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation
import SVProgressHUD
import Alamofire

class Utils {
    class func showProgress(){
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.show()
    }
    class func dissmissProgress(){
        SVProgressHUD.dismiss()
    }
    
    static func setStatusBarColor(color : UIColor){
        //Status bar style and visibility
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Change status bar color
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = color
        }
    }
    
    struct Connectivity {
        static let sharedInstance = NetworkReachabilityManager()!
        static var isConnectedToInternet:Bool {
            return self.sharedInstance.isReachable
        }
    }
    
    static func isInternetAvailable()-> Bool{
        
        if Connectivity.isConnectedToInternet {
            return true
        } else {
            return false
        }
    }
    
    static func orderStatusIconProvider(status: Int)-> UIImage {
        switch status {
        case 1:
            return UIImage(named: "ic_settled")!
        case 2:
           return  UIImage(named: "ic_cancelled_white")!
        case 3:
            return UIImage(named: "ic_open")!
        case 4:
            return UIImage(named: "ic_pending_settlement")!
        default:
            return UIImage()
        }
    }
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        //self.cornerRadiusPreset = CornerRadiusPreset(rawValue: 1)!

        
        // self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        // self.layer.shouldRasterize = true
        // self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
