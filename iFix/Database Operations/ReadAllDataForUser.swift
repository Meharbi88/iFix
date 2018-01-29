//
//  ReadAllDataForUser.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/17/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import Foundation
import Firebase

class ReadAllDataForUser {
    
    
    class func readServices(userId:String, serviceState: String) {
        if(serviceState == "unclaimed services"){
            DataCurrentUser.unclaimedServices = []
        }else if(serviceState == "in progress services"){
            DataCurrentUser.inProgressServices = []
        }else {
            DataCurrentUser.completeServices = []
        }
        print(userId)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(serviceState).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let key = snapshot.value as? NSDictionary
            if (key != nil){
                for value in (key?.allValues)!{
                    let value2 = value as! NSDictionary
                    if((value2.value(forKey: "userId") as! String) == userId){
                        let type = value2.value(forKey: "type") as! String
                        let name = value2.value(forKey: "name") as! String
                        let description = value2.value(forKey: "description") as! String
                        let serviceId = value2.value(forKey: "serviceId") as! String
                        let userId = value2.value(forKey: "userId") as! String
                        let serviceProviderId = value2.value(forKey: "serviceProviderId") as! String
                        let status = value2.value(forKey: "status") as! String
                        let userPhone = value2.value(forKey: "userPhone") as! String
                        let userAddress = value2.value(forKey: "userAddress") as! String
                        let offerId = value2.value(forKey: "offerId") as! String
                        switch (serviceState){
                        case "unclaimed services" :
                            DataCurrentUser.unclaimedServices.append(Service(type: type, name: name, description: description, serviceId: serviceId, userId: userId, serviceProviderId: serviceProviderId, status: status, userPhone: userPhone, userAddress: userAddress, offerId: offerId))
                        case "in progress services":
                            DataCurrentUser.inProgressServices.append(Service(type: type, name: name, description: description, serviceId: serviceId, userId: userId, serviceProviderId: serviceProviderId, status: status, userPhone: userPhone, userAddress: userAddress, offerId: offerId))
                        case "complete services":
                            DataCurrentUser.completeServices.append(Service(type: type, name: name, description: description, serviceId: serviceId, userId: userId, serviceProviderId: serviceProviderId, status: status, userPhone: userPhone, userAddress: userAddress, offerId: offerId))
                        default:
                            break
                        }
                    }
                    
                }
            }
            })
            { (error) in
                print(error.localizedDescription)
            }
    }
    
    class func readOffers(userId:String) {
        DataCurrentUser.undeterminedOffers = []
        DataCurrentUser.acceptedOffers = []
        DataCurrentUser.declinedOffers = []

        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("offers").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let key = snapshot.value as? NSDictionary
            if (key != nil){
                for value in (key?.allValues)!{
                    let value2 = value as! NSDictionary
                    if((value2.value(forKey: "userId") as! String) == userId){
                        let offerId = value2.value(forKey: "offerId") as! String
                        let price = value2.value(forKey: "price") as! String
                        let serviceId = value2.value(forKey: "serviceId") as! String
                        let userId = value2.value(forKey: "userId") as! String
                        let state = value2.value(forKey: "state") as! String
                        let serviceProviderId = value2.value(forKey: "serviceProviderId") as! String

                        switch(state){
                        case "undetermined":
                            DataCurrentUser.undeterminedOffers.append(Offer(offerId: offerId, price: price, serviceId: serviceId, userId: userId, state:state, serviceProviderId: serviceProviderId))
                        case "accepted":
                            DataCurrentUser.acceptedOffers.append(Offer(offerId: offerId, price: price, serviceId: serviceId, userId: userId, state:state, serviceProviderId : serviceProviderId))
                        case "declined":
                            DataCurrentUser.declinedOffers.append(Offer(offerId: offerId, price: price, serviceId: serviceId, userId: userId, state:state, serviceProviderId: serviceProviderId))
                        default:
                            break
                        }
                    }
                    
                }
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
}
