//
//  APIErrorModel.swift
//  POS
//
//  Created by Ashwani Kumar on 29/06/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import UIKit

class APIErrorModel: Codable {
    var status_code : Int?
    var detail : String?
}
