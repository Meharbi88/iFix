//
//  ServiceProvider.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/12/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import Foundation

class ServiceProvider{
    
    var email: String
    var firstName: String
    var lastName: String
    var password: String
    var type: String
    var serviceProviderId: String

    
    init(email: String, firstName: String, lastName: String, password: String, type: String, serviceProviderId: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.type = type
        self.serviceProviderId = serviceProviderId
        
    }
    init(){
        
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.password = ""
        self.type = ""
        self.serviceProviderId = ""
        
    }
    
}
