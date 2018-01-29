//
//  WriteData.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/17/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import Foundation
import Firebase

class WriteData {
    
    
    class func writeUser(user: User){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let newUser = ["email": user.email, "firstName": user.firstName, "lastName": user.lastName,"password": user.password,"type":user.type,"userId": user.userId]
        
        ref.root.child("users").child(user.userId).setValue(newUser)
        
    }
    
    class func writeServiceProvider(serviceProvider: ServiceProvider){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let newServiceProvider = ["email": serviceProvider.email, "firstName": serviceProvider.firstName, "lastName": serviceProvider.lastName,"password": serviceProvider.password,"type":serviceProvider.type,"serviceProviderId": serviceProvider.serviceProviderId]
        
        ref.root.child("serviceProviders").child(serviceProvider.serviceProviderId).setValue(newServiceProvider)
        
    }
    
    class func writeUnclaimedService(service: Service){
        
        var ref: DatabaseReference!
        ref = Database.database().reference().child("unclaimed services").child(service.serviceId)
        
        let newService = ["type": service.type, "name": service.name, "description": service.description,"userId": service.userId, "serviceProviderId": service.serviceProviderId, "userPhone":service.userPhone,"userAddress": service.userAddress, "status": service.status, "serviceId": service.serviceId, "offerId": service.offerId]
        
        ref.setValue(newService)
        
    }
    
    class func writeInProgressService(service: Service){
        
        var ref: DatabaseReference!
        ref = Database.database().reference().child("in progress services").child(service.serviceId)
        
        let newService = ["type": service.type, "name": service.name, "description": service.description,"userId": service.userId, "serviceProviderId": service.serviceProviderId, "userPhone":service.userPhone,"userAddress": service.userAddress, "status": service.status, "serviceId": service.serviceId, "offerId": service.offerId]
        
        ref.setValue(newService)
        
    }
    
    class func writeCompleteService(service: Service){
        
        var ref: DatabaseReference!
        ref = Database.database().reference().child("complete services").child(service.serviceId)
        
        let newService = ["type": service.type, "name": service.name, "description": service.description,"userId": service.userId, "serviceProviderId": service.serviceProviderId, "userPhone":service.userPhone,"userAddress": service.userAddress, "status": service.status, "serviceId": service.serviceId, "offerId": service.offerId]
        
        ref.setValue(newService)
        
    }
    
    class func writeOffer(offer: Offer){
        
        var ref: DatabaseReference!
        ref = Database.database().reference().child("offers").child(offer.offerId)
        
        let newOffer = ["offerId": offer.offerId, "price": offer.price, "serviceId": offer.serviceId, "userId": offer.userId , "state": offer.state, "serviceProviderId": offer.serviceProviderId]
        
        ref.setValue(newOffer)
    }
    
    
    
    
}
