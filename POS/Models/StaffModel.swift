//
//  StaffModel.swift
//  POS
//
//  Created by Ashwani Kumar on 01/07/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation

class StaffMainModel : Codable{
    var staffList : [StaffModel]
}


class StaffModel: Codable {
    let id : Int
    let first_name : String
    let last_name : String
    let email : String
}
