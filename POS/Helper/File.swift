//
//  File.swift
//  POS
//
//  Created by Ashwani Kumar on 30/06/19.
//  Copyright © 2019 Djubo. All rights reserved.
//

import Foundation

class ApplicationVariables{
    
    static let sharedInstance = ApplicationVariables()
    
    var loginUser : UserAccountModel?
    var properties : [PropertyModel]?
    var selectedProperty : PropertyModel?
    var staffList : [StaffModel]?
    var selectedOutlet :OutletModel?
    init() {
        
    }
}
