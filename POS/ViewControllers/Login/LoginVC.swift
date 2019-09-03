//
//  LoginVC.swift
//  POS
//
//  Created by Djubo on 29/06/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation
import UIKit
import Material
import Alamofire

class LoginVC: UIViewController {
    @IBOutlet weak var userNameTf: TextField!
    @IBOutlet weak var passwordTf: TextField!
    
    @IBOutlet weak var submitBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
       // addTapGestureOnScrollView()

        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        
        setTextFieldTheme(textField: userNameTf, placeHolder: NSLocalizedString("username", comment: ""))
        setTextFieldTheme(textField: passwordTf, placeHolder: NSLocalizedString("password", comment: ""))
        userNameTf.text = "ashish123@djubo.com"
        passwordTf.text = "test123"
        
      //  submitBtn.setTitleColor(ThemeColors.getThemeGreenColor(), for: .normal)
        passwordTf.isVisibilityIconButtonEnabled = true
        
       // Utils.setStatusBarColor(color: ThemeColors.getStatusBarGrey())
    }
    
    func setTextFieldTheme(textField : TextField, placeHolder : String){
        
        textField.placeholderNormalColor = UIColor.white
        textField.placeholderActiveColor = UIColor.white
        textField.textColor = UIColor.white
        textField.dividerNormalColor = UIColor.white
        textField.dividerActiveColor = UIColor.white
        textField.placeholder = placeHolder
        textField.detailColor = UIColor.white
        textField.delegate = self
        
        textField.font = UIFont(name: Constants.fontRegularName, size: 15)
    }
    
    @IBAction func submitBtnClick(_ sender: Any) {
        
        if validateData(){
            Utils.showProgress()
            print("API Call for login")
            var params:[String:Any] = [:]
            params["email_address"] = userNameTf.text
            params["password"] = passwordTf.text
            let request = APIRequestHelper.loginTask(parameters: params as [String : AnyObject])
            
            request.perform(withSuccess: {response in

                print("Login Success \(response.access_token)")

                UserDefaultsHelper.saveStringPreferences(key: UserDefaultKeys.access_token, value: response.access_token)
                UserDefaultsHelper.saveStringPreferences(key: UserDefaultKeys.version, value: response.version)
                UserDefaultsHelper.saveBooleanPreferences(key: UserDefaultKeys.isAccountDisabled, value: response.is_disabled)
                UserDefaultsHelper.saveDoublePreferences(key: UserDefaultKeys.payableAmount, value: response.payable_amount)
                if response.is_disabled{
                    // account is disabled show disabled popup

                 //   self.showDisablePropertyPopup(amount: response.payable_amount)
                }else{
                    // get login user account details
                    self.getAccountDetails()
                }

            }, failure: {error in
                Utils.dissmissProgress()

                if (error.response?.statusCode == 401){
                    self.passwordTf.text = ""
                    self.passwordTf.becomeFirstResponder()
                //    Utils.showSnackBar(messageStr: NSLocalizedString("invalid_login", comment: ""))
                }else{
                  //  Utils.showSnackBar(messageStr: NSLocalizedString("general_error", comment: ""))
                }
            })
        }
    }
    

    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    func validateData() -> Bool {
        if (userNameTf.text?.isEmpty)!{
            userNameTf.detail = NSLocalizedString("empty_username", comment: "")
            userNameTf.becomeFirstResponder()
            return false
        }else if (passwordTf.text?.isEmpty)!{
            passwordTf.detail = NSLocalizedString("empty_password", comment: "")
            passwordTf.becomeFirstResponder()
            return false
        }
        
        return true
    }
    
    func getAccountDetails(){
        let request = APIRequestHelper.getAccountDetailsRequest()
        
        request.perform(withSuccess: {response in
            
            print("Account Details \(response.first_name)")
            ApplicationVariables.sharedInstance.loginUser = response
            UserDefaultsHelper.saveBooleanPreferences(key: UserDefaultKeys.isLogin, value: true)
            self.getPropertiesData()
            
        }, failure: {error in
            
            Utils.dissmissProgress()
        })
    }
    
    func getPropertiesData(){
        let request = APIRequestHelper.getPropertiesMetadata()
        request.perform(withSuccess: {propertiesList in
            ApplicationVariables.sharedInstance.properties = propertiesList
            for property in propertiesList {
                if property.is_default_property! {
                    ApplicationVariables.sharedInstance.selectedProperty = property
                    self.getStaffListData()
                }
            }
            
        }, failure: {error in
            Utils.dissmissProgress()
        })
    }

     func getStaffListData(){
        
        let request = APIRequestHelper.getStaffListData()
        
        
        request.perform(withSuccess: {staffList in
            ApplicationVariables.sharedInstance.staffList = staffList
            self.getOutletsData()
        }, failure: {error in
            Utils.dissmissProgress()
            //Utils.apiErrorHandling(error: error.errorModel!)
        })
        
    }
    
    func getOutletsData() {
        let request = APIRequestHelper.getOutletMetaData()
        request.perform(withSuccess: {outletData in
            print(outletData)
            Utils.dissmissProgress()
        
            for outlet in outletData.outlets {
                if outlet.propertyId == ApplicationVariables.sharedInstance.selectedProperty?.id {
                    Utils.dissmissProgress()
                    ApplicationVariables.sharedInstance.selectedOutlet = outlet
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.showHomeScreen()
                    break
                }
            }

        }, failure: {error in
            Utils.dissmissProgress()

        })
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

extension LoginVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == userNameTf){
            return passwordTf.becomeFirstResponder()
        }else if (textField == passwordTf){
            submitBtn.sendActions(for: .touchUpInside)
            passwordTf.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(textField: UITextField, didChange text: String?) {
        userNameTf.detail = ""
        passwordTf.detail = ""
    }
    
}
