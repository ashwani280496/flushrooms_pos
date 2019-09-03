//
//  UserAccountModel.swift
//  POS
//
//  Created by Ashwani Kumar on 30/06/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import UIKit
class UserAccountModel :Codable{
    
    let account: Int
    let first_name: String
    let last_name: String
    let email: String
    let permissions: [String]
    let id : Int!

}

