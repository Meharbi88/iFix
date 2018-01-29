//
//  Offer.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/17/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import Foundation
class Offer{
    var offerId : String
    var price : String
    var serviceId : String
    var serviceProviderId : String
    var userId : String
    var state : String
    
    init(offerId: String, price: String, serviceId: String, userId: String, state: String, serviceProviderId: String) {
        self.offerId = offerId
        self.price = price
        self.serviceId = serviceId
        self.userId = userId
        self.state = state
        self.serviceProviderId = serviceProviderId
    }
    
    init() {
        self.offerId = ""
        self.price = ""
        self.serviceId = ""
        self.userId = ""
        self.state = ""
        self.serviceProviderId = ""
    }
    
    
}
