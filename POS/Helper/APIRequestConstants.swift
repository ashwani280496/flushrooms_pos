//
//  APIRequestConstants.swift
//  POS
//
//  Created by Ashwani Kumar on 29/06/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation

class APIRequestConstants {
    static let baseUrl = "https://beta.djubo.com"
    static let authorizationHeader = "X-DJ-AUTH"
    static let versionHeader = "API_VERSION_URL"
    static let contentType = "Content-Type"
    
    // API Methods
    // Login and Account API urls
    static let loginUrl = "m_sign-in/"
    static let self_url = "core-data/staffs/self"
    static let forgotPasswordUrl = "m/password/forgot/"
    
    // Property API url
    static let propertyUrl = "core-data/properties/"
    static let staffUrl = "core-data/accounts/%d/properties/%d/staffs"
    
    public static let accountOutletsUrl = "core-data/accounts/%d/outlets";
    public static let itemsUrl = "rates-data/accounts/%d/properties/%d/items/";
    public static let ordersUrl = "order-data/accounts/%d/properties/%d/orders";
    public static let historyOrderUrl = "order-data/accounts/%d/properties/%d/historical-orders"
    public static let guestUrl = "order-data/accounts/%d/properties/%d/pos-guest/";
    public static let occupiedRoomsURL = "order-data/accounts/%d/properties/%d/fetch-occupied-rooms";
    public static let sendEmailUrl = "order-data/accounts/%d/properties/%d/send-email";
    public static let generateBillUrl = "order-data/accounts/%d/properties/%d/generate-pos-bill";
    public static let orderHistoryUrl = "order-data/accounts/%d/properties/%d/order-history";
    public static let undoPushTORoomUrl = "order-data/accounts/%d/properties/%d/undo-push-to-room/";
    public static let guestsUrl = "core-data/accounts/%d/properties/%d/guests";
    public static let posGuestsUrl = "accounts/%d/properties/%d/pos-guest/";
    public static let companyDetailUrl = "core-data/accounts/%d/properties/%d/company";
    public static let posBillingPreferenceUrl = "order-data/accounts/%d/properties/%d/pos-billing-preference";
    public static let multiplePrintSetting = "order-data/accounts/%d/properties/%d/pos-print-setting";
    // Location API URl
    public static let locationsUrl = "core-data/accounts/%d/properties/%d/locations/";
}
