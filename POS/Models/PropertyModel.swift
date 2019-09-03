//
//  PropertyModel.swift
//  POS
//
//  Created by Ashwani Kumar on 01/07/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation
class PropertyModel : Codable {
    let id : Int
    let name : String?
    let is_default_property : Bool?
//    //var room_categories : [CategoryModel]
    let time_zone : String?
    let currency : String?
    let currency_format : String?
    var tax_type : Int?
//    var company_statutory_identities: [StatutorySettingRespModel]?
}
