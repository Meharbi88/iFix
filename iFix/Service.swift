//
//  Service.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/12/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import Foundation

class Service{
    
    var type: String
    var name: String
    var description: String
    var serviceId: String
    var userId: String
    var userPhone : String
    var userAddress : String
    var status: String

    init(type: String, name: String, description: String, userId: String, userPhone: String, userAddress: String) {
        self.type = type
        self.name = name
        self.description = description
        self.serviceId = ""
        self.userId = userId
        self.status = "unclaimed"
        self.userPhone = userPhone
        self.userAddress = userAddress
        
    }
    
}
