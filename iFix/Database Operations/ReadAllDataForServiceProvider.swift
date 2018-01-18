//
//  ReadAllDataForServiceProvider.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/17/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import Foundation
import Firebase

class ReadAllDataForServiceProvider {
    
    class func readUnclaimedServices(type : String) {
        DataCurrentServiceProvider.unclaimedServices = []
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("unclaimed services").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let key = snapshot.value as? NSDictionary
            if(key != nil){
                for value in (key?.allValues)!{
                    let value2 = value as! NSDictionary
                    if((value2.value(forKey: "type") as! String) == type){
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
                        DataCurrentServiceProvider.unclaimedServices.append(Service(type: type, name: name, description: description, serviceId: serviceId, userId: userId, serviceProviderId: serviceProviderId, status: status, userPhone: userPhone, userAddress: userAddress, offerId: offerId))
                        print(DataCurrentServiceProvider.unclaimedServices[0].name)
                    }
                }
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    class func readServices(serviceProviderId :String, serviceState: String) {
        if(serviceState == "in progress services"){
            DataCurrentServiceProvider.inProgressServices = []
        }else{
            DataCurrentServiceProvider.completeServices = []
        }
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(serviceState).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let key = snapshot.value as? NSDictionary
            if(key != nil){
                for value in (key?.allValues)!{
                    let value2 = value as! NSDictionary
                    if((value2.value(forKey: "serviceProviderId") as! String) == serviceProviderId){
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
                        case "in progress services":
                            DataCurrentServiceProvider.inProgressServices.append(Service(type: type, name: name, description: description, serviceId: serviceId, userId: userId, serviceProviderId: serviceProviderId, status: status, userPhone: userPhone, userAddress: userAddress,offerId:offerId))

                        case "complete services":
                            DataCurrentServiceProvider.completeServices.append(Service(type: type, name: name, description: description, serviceId: serviceId, userId: userId, serviceProviderId: serviceProviderId, status: status, userPhone: userPhone, userAddress: userAddress, offerId: offerId))

                        default:
                            break;
                        }
                    
                    }
                }
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    class func readOffers(serviceProviderId:String) {
        DataCurrentServiceProvider.undeterminedOffers = []
        DataCurrentServiceProvider.acceptedOffers = []
        DataCurrentServiceProvider.declinedOffers = []
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("offers").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let key = snapshot.value as? NSDictionary
            if (key != nil){
                for value in (key?.allValues)!{
                    let value2 = value as! NSDictionary
                    if((value2.value(forKey: "serviceProviderId") as! String) == serviceProviderId){
                        let offerId = value2.value(forKey: "offerId") as! String
                        let price = value2.value(forKey: "price") as! String
                        let serviceId = value2.value(forKey: "serviceId") as! String
                        let userId = value2.value(forKey: "userId") as! String
                        let state = value2.value(forKey: "state") as! String
                        let serviceProviderId = value2.value(forKey: "serviceProviderId") as! String

                        switch(state){
                        case "undetermined":
                            DataCurrentServiceProvider.undeterminedOffers.append(Offer(offerId: offerId, price: price, serviceId: serviceId, userId: userId, state:state, serviceProviderId: serviceProviderId))
                        case "accepted":
                            DataCurrentServiceProvider.acceptedOffers.append(Offer(offerId: offerId, price: price, serviceId: serviceId, userId: userId, state:state, serviceProviderId: serviceProviderId))
                        case "declined":
                            DataCurrentServiceProvider.declinedOffers.append(Offer(offerId: offerId, price: price, serviceId: serviceId, userId: userId, state:state, serviceProviderId: serviceProviderId))
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
