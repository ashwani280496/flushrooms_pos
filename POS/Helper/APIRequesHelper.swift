//
//  APIRequesHelper.swift
//  POS
//
//  Created by Ashwani Kumar on 29/06/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation
import TRON
import Alamofire

class APIRequestHelper {
    static let tron = TRON(baseURL: APIRequestConstants.baseUrl)
    
    static func getHeader() -> [String:String]{
        let token = UserDefaultsHelper.readPreferencesString(key: UserDefaultKeys.access_token)
        let version = UserDefaultsHelper.readPreferencesString(key: UserDefaultKeys.version)
        
        return  [APIRequestConstants.authorizationHeader :token,
                 APIRequestConstants.versionHeader : version]
    }
    
    static func loginTask(parameters: [String:AnyObject]) -> APIRequest<LoginModel, APIErrorModel> {
        let request: APIRequest<LoginModel, APIErrorModel> = tron.codable.request(APIRequestConstants.loginUrl)
        request.method = .post
        request.parameters = parameters
        request.parameterEncoding = URLEncoding.default
        return request
    }
    
    static func getAccountDetailsRequest() -> APIRequest<UserAccountModel,APIErrorModel>{
        let request: APIRequest<UserAccountModel,APIErrorModel> = tron.codable.request(APIRequestConstants.self_url)
        request.method = .get
        request.headers = getHeader()
        return request
    }
    
    static func getPropertiesMetadata() ->  APIRequest<[PropertyModel], APIErrorModel> {
        let request: APIRequest<[PropertyModel], APIErrorModel> = tron.codable.request(APIRequestConstants.propertyUrl)
        request.method = .get
        request.headers = getHeader()
        return request
    }
    
    static func getStaffListData() -> APIRequest<[StaffModel], APIErrorModel> {
        let url = String.init(format: APIRequestConstants.staffUrl,(ApplicationVariables.sharedInstance.loginUser?.account)!, (ApplicationVariables.sharedInstance.selectedProperty?.id)!)
        let request: APIRequest<[StaffModel], APIErrorModel> = tron.codable.request(url)
        request.method = .get
        request.headers = getHeader()
        return request
    }
    
    static func getOutletMetaData() -> APIRequest<OutletMainModel, APIErrorModel> {
        let url = String.init(format: APIRequestConstants.accountOutletsUrl,(ApplicationVariables.sharedInstance.loginUser?.account)!)
        let request: APIRequest<OutletMainModel, APIErrorModel> = tron.codable.request(url)
        request.method = .get
        request.headers = getHeader()
        return request
    }
    
    static func getOrders(params: [String:AnyObject]) -> APIRequest<[OrdersResponseModel],APIErrorModel> {
        let url = String.init(format: APIRequestConstants.ordersUrl,(ApplicationVariables.sharedInstance.loginUser?.account)!, ApplicationVariables.sharedInstance.selectedProperty!.id)
        let request: APIRequest<[OrdersResponseModel], APIErrorModel> = tron.codable.request(url)
        request.method = .get
        request.parameters = params
        request.headers = getHeader()
        return request
    }
    
    static func getHisotircalOrders(params: [String:AnyObject]) -> APIRequest<[OrdersResponseModel],APIErrorModel> {
        let url = String.init(format: APIRequestConstants.historyOrderUrl,(ApplicationVariables.sharedInstance.loginUser?.account)!, ApplicationVariables.sharedInstance.selectedProperty!.id)
        let request: APIRequest<[OrdersResponseModel], APIErrorModel> = tron.codable.request(url)
        request.method = .get
        request.parameters = params
        request.headers = getHeader()
        return request
    }
    
}
