//
//  LoginModel.swift
//  POS
//
//  Created by Ashwani Kumar on 29/06/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation
import UIKit
class LoginModel: Codable {
    let access_token : String
    let version: String
    let is_disabled : Bool
    let payable_amount : Double
}
