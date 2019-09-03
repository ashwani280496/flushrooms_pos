//
//  OutletModel.swift
//  POS
//
//  Created by Ashwani Kumar on 05/07/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation

class OutletMainModel : Codable {
    let outlets : [OutletModel]
}
class OutletModel:Codable{
    let id: Int
    let displayName: String
    let displayOrder: Int
    let propertyId : Int
    let priceOverride : Bool
    let deliveries : [DeliveriesModel]

}

class DeliveriesModel : Codable {
    let deliveryDisplayModes : [DeliveryDisplayMode]
    let deliveryDisplayName : String?
    let displayName : String
    let displayOrder : Int
    let id : Int
    let isContainerDisplay : Bool
    let isRoomContainer : Bool
}

class DeliveryDisplayMode : Codable{
    
    let displayName : String
    let displayOrder : Int
    let id : Int
}

