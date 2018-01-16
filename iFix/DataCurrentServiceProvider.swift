//
//  DataCurrentServiceProvider.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/15/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import Foundation
import Firebase

class DataCurrentServiceProvider: NSObject {
    
    static var serviceProviderId : String = ""
    static var serviceProvider : ServiceProvider = ServiceProvider()
    static var unclaimedServices : [Service] = []
    //static var offersServices : [Offer] = []
    static var inProgressServices : [Service] = []
    static var completeServices : [Service] = []
    
    class func loadCurrentServiceProviderData(){
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
                let userId = value?.value(forKey: "userId") as! String
                let password = value?.value(forKey: "password") as! String
                serviceProvider = ServiceProvider(email: email, firstName: firstName, lastName: lastName, password: password, type: type, userId: userId)
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    class func loadUnclaimedServicesData(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("unclaimed services").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let key = snapshot.value as? NSDictionary
            for value in (key?.allValues)!{
                let value2 = value as! NSDictionary
                if((value2.value(forKey: "type") as! String) == serviceProvider.type){
                    let type = value2.value(forKey: "type") as! String
                    let name = value2.value(forKey: "name") as! String
                    let description = value2.value(forKey: "description") as! String
                    let serviceId = value2.value(forKey: "serviceId") as! String
                    let userId = value2.value(forKey: "userId") as! String
                    let serviceProviderId = value2.value(forKey: "serviceProviderId") as! String
                    let status = value2.value(forKey: "status") as! String
                    let userPhone = value2.value(forKey: "userPhone") as! String
                    let userAddress = value2.value(forKey: "userAddress") as! String
                    unclaimedServices.append(Service(type: type, name: name, description: description, serviceId: serviceId, userId: userId, serviceProviderId: serviceProviderId, status: status, userPhone: userPhone, userAddress: userAddress))
                    serviceProvider.listOfUnclaimedServices.append(serviceId)
                }

            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
  
    
//    class func loadServices1(){
//        unclaimedServices = []
//        print("\(user.listOfUnclaimedServices.count)")
//        for unclaimedServiceId in user.listOfUnclaimedServices{
//            var ref: DatabaseReference!
//            ref = Database.database().reference()
//            ref.child("unclaimed services").child(unclaimedServiceId).observeSingleEvent(of: .value, with: { (snapshot) in
//                // Get user value
//                let value = snapshot.value as? NSDictionary
//                if(value != nil){
//                    let type = value?.value(forKey: "type") as! String
//                    let name = value?.value(forKey: "name") as! String
//                    let description = value?.value(forKey: "description") as! String
//                    let serviceId = value?.value(forKey: "serviceId") as! String
//                    let userId = value?.value(forKey: "userId") as! String
//                    let userPhone = value?.value(forKey: "userPhone") as! String
//                    let userAddress = value?.value(forKey: "userAddress") as! String
//                    let status = value?.value(forKey: "status") as! String
//                    let serviceProviderId = value?.value(forKey: "serviceProviderId") as! String
//                    unclaimedServices.append(Service(type: type, name: name, description: description, serviceId: serviceId, userId: userId, serviceProviderId: serviceProviderId, status: status, userPhone: userPhone, userAddress: userAddress))
//                }
//
//            })
//            { (error) in
//                print(error.localizedDescription)
//            }
//        }
    
        
    class func clear(){
        serviceProvider = ServiceProvider()
        unclaimedServices = []
        // offersServices = []
        inProgressServices = []
        completeServices = []
    }
        
}
