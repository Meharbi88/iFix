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
    static var serviceProviderType : String = ""
    static var serviceProvider : ServiceProvider = ServiceProvider()
    static var unclaimedServices : [Service] = []
    static var inProgressServices : [Service] = []
    static var completeServices : [Service] = []
    
    static var undeterminedOffers : [Offer] = []
    static var acceptedOffers : [Offer] = []
    static var declinedOffers : [Offer] = []

    
    class func loadCurrentServiceProviderData(){
        ReadData.readServiceProvider(serviceProviderId: serviceProviderId)
    }
    
    
    class func loadUnclaimedServicesData(){
        ReadAllDataForServiceProvider.readUnclaimedServices(type: serviceProviderType)
    }
    
    class func loadInProgressServicesData(){
        ReadAllDataForServiceProvider.readServices(serviceProviderId :serviceProviderId, serviceState: "in progress services")
    }
    
    class func loadCompleteServicesData(){
        ReadAllDataForServiceProvider.readServices(serviceProviderId :serviceProviderId, serviceState: "complete services")
    }
    
    class func loadOffersData(){
        ReadAllDataForServiceProvider.readOffers(serviceProviderId: serviceProviderId)
    }
    
    class func deleteUndeterminedOffersLocally(offer : Offer){
        for index in 0..<undeterminedOffers.count {
            if (undeterminedOffers[index].offerId == offer.offerId) {
                undeterminedOffers.remove(at: index)
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
    
    class func addCompleteServicesLocally(service: Service){
        completeServices.append(service)
    }
    
    class func addCompleteServicesData(service: Service){
        WriteData.writeCompleteService(service: service)
    }
    
    class func addUnclaimedServicesLocally(service: Service){
        unclaimedServices.append(service)
    }
    
    class func deleteInProgressServiceData(service: Service){
        DeleteData.deleteService(serviceId: service.serviceId, serviceState: "in progress services")
    }
    
    class func addUnclaimedServicesData(service: Service){
        WriteData.writeUnclaimedService(service: service)
    }
    
    class func deleteOfferData(offer : Offer){
        DeleteData.deleteOffer(offerId : offer.offerId)
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
        
    class func clear(){
        serviceProvider = ServiceProvider()
        unclaimedServices = []
        inProgressServices = []
        completeServices = []
        
        undeterminedOffers = []
        acceptedOffers = []
        declinedOffers = []
    }
        
}
