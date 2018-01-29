//
//  Service.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/12/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import Foundation

class Service{
    
    var type: String
    var name: String
    var description: String
    var serviceId: String
    var userId: String
    var serviceProviderId: String
    var userPhone : String
    var userAddress : String
    var status: String
    var offerId : String

    init(type: String, name: String, description: String, serviceId: String, userId: String, serviceProviderId: String, status: String, userPhone: String, userAddress: String, offerId: String) {
        self.type = type
        self.name = name
        self.description = description
        self.serviceId = serviceId
        self.userId = userId
        self.serviceProviderId = serviceProviderId
        self.status = status
        self.userPhone = userPhone
        self.userAddress = userAddress
        self.offerId = offerId
        
    }
    
    
}
