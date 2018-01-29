//
//  ReadData.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/17/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import Foundation
import Firebase

class ReadData {
    
    class func readUser(userId: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if(value != nil){
                let type = value?.value(forKey: "type") as! String
                let email = value?.value(forKey: "email") as! String
                let firstName = value?.value(forKey: "firstName") as! String
                let lastName = value?.value(forKey: "lastName") as! String
                let userId = value?.value(forKey: "userId") as! String
                let password = value?.value(forKey: "password") as! String
                print("\(type) \(email) \(firstName) \(lastName) \(userId) \(password)")
                DataCurrentUser.user = User(email: email, firstName: firstName, lastName: lastName, password: password, type: type, userId: userId)
                DataCurrentUser.userId = userId
                DataCurrentUser.userType = type
                DataCurrentUser.loadUnclaimedServicesData()
                DataCurrentUser.loadInProgressServicesData()
                DataCurrentUser.loadCompleteServicesData()
                DataCurrentUser.loadOffersData()
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    class func readServiceProvider(serviceProviderId: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("serviceProviders").child(serviceProviderId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            if(value != nil){
                let type = value?.value(forKey: "type") as! String
                let email = value?.value(forKey: "email") as! String
                let firstName = value?.value(forKey: "firstName") as! String
                let lastName = value?.value(forKey: "lastName") as! String
                let serviceProviderId = value?.value(forKey: "serviceProviderId") as! String
                let password = value?.value(forKey: "password") as! String
                DataCurrentServiceProvider.serviceProvider = ServiceProvider(email: email, firstName: firstName, lastName: lastName, password: password, type: type, serviceProviderId: serviceProviderId)
                DataCurrentServiceProvider.serviceProviderId = serviceProviderId
                DataCurrentServiceProvider.serviceProviderType = type
                DataCurrentServiceProvider.loadUnclaimedServicesData()
                DataCurrentServiceProvider.loadInProgressServicesData()
                DataCurrentServiceProvider.loadCompleteServicesData()
                DataCurrentServiceProvider.loadOffersData()
                print(type)
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    

}
