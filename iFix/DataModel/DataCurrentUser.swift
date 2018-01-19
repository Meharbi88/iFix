//
//  DataCurrentUser.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/12/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit
import Firebase

class DataCurrentUser: NSObject {
    
    static var userId : String = ""
    static var userType: String = ""
    static var user : User = User()
    static var unclaimedServices : [Service] = []
    static var inProgressServices : [Service] = []
    static var completeServices : [Service] = []
    static var undeterminedOffers : [Offer] = []
    static var acceptedOffers : [Offer] = []
    static var declinedOffers : [Offer] = []

    //Loading Data
    class func loadCurrentUserData(){
        ReadData.readUser(userId: userId)
    }
    
    class func loadUnclaimedServicesData(){
        ReadAllDataForUser.readServices(userId : userId, serviceState: "unclaimed services")
    }
    
    class func loadInProgressServicesData(){
        ReadAllDataForUser.readServices(userId : userId, serviceState: "in progress services")
    }
    
    class func loadCompleteServicesData(){
        ReadAllDataForUser.readServices(userId : userId, serviceState: "complete services")
    }
    
    class func loadOffersData(){
        ReadAllDataForUser.readOffers(userId: userId)
    }
    
    //Updating Data Locally
    class func deleteUnclaimedServiceLocally(service : Service){
        for index in 0..<unclaimedServices.count {
            if (unclaimedServices[index].serviceId == service.serviceId) {
                unclaimedServices.remove(at: index)
                break;
            }
        }        
    }
    
    class func deleteInProgressServiceLocally(service: Service){
        for index in 0..<inProgressServices.count {
            if (inProgressServices[index].serviceId == service.serviceId) {
                inProgressServices.remove(at: index)
                break;
            }
        }
    }
    
    class func deleteOfferLocally(offerId : String){
        for index in 0..<undeterminedOffers.count {
            if (undeterminedOffers[index].offerId == offerId) {
                undeterminedOffers.remove(at: index)
                break;
            }
        }
    }
    
    class func addUnclaimedServicesLocally(service: Service){
        unclaimedServices.append(service)
    }
    
    class func updateOfferDeclinedLocally(offer: Offer){
        for index in 0..<undeterminedOffers.count {
            if (undeterminedOffers[index].offerId == offer.offerId) {
                undeterminedOffers.remove(at: index)
                break;
            }
        }
        declinedOffers.append(offer)
    }
    
    class func updateOfferAcceptedLocally(offer : Offer, service : Service){
        for index in 0..<undeterminedOffers.count {
            if (undeterminedOffers[index].offerId == offer.offerId) {
                undeterminedOffers.remove(at: index)
                break;
            }
        }
        acceptedOffers.append(offer)
        inProgressServices.append(service)
        deleteUnclaimedServiceLocally(service: service)
        deleteUnclaimedServiceData(service: service)
    }
    
    class func getServiceFromUnclaimedServices(serviceId: String) -> Service?{
        
        for index in 0..<unclaimedServices.count {
            if (unclaimedServices[index].serviceId == serviceId) {
                return unclaimedServices[index]
            }
        }
        return nil
    }
    
    class func getOfferPriceFromOfferAccpted(offerId: String) -> String{
        
        for index in 0..<acceptedOffers.count {
            if (acceptedOffers[index].offerId == offerId) {
                return acceptedOffers[index].price
            }
        }
        return "Not Existed"
    }

    //Database
    class func deleteUnclaimedServiceData(service : Service){
        DeleteData.deleteService(serviceId: service.serviceId, serviceState: "unclaimed services")
    }
    
    class func deleteInProgressServiceData(service: Service){
        DeleteData.deleteService(serviceId: service.serviceId, serviceState: "in progress services")
    }
    
    class func addUnclaimedServicesData(service: Service){
        WriteData.writeUnclaimedService(service: service)
    }
    
    class func updateOfferAcceptedDatabase(offer : Offer, service : Service){
        WriteData.writeOffer(offer: offer)
        WriteData.writeInProgressService(service: service)
    }
    
    class func updateOfferDeclinedDatabase (offer: Offer){
        WriteData.writeOffer(offer: offer)
    }
    
    
    class func clear(){
        user = User()
        userType = ""
        unclaimedServices = []
        inProgressServices = []
        completeServices = []
        undeterminedOffers = []
        acceptedOffers = []
        declinedOffers = []

    }
    
}
