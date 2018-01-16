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
    //static var offersServices : [Offer] = []
    static var inProgressServices : [Service] = []
    static var completeServices : [Service] = []
    static var listOfUnclaimedServices : [String] = []
    static var listOfInProgressServices : [String] = []
    static var listOfOffers : [String] = []
    static var listOfCompleteServices : [String] = []

    class func loadCurrentUserData(){
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
                user = User(email: email, firstName: firstName, lastName: lastName, password: password, type: type, userId: userId)
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    class func loadUnclaimedServicesData(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child(userId).child("listOfUnclaimedServices").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSArray
            if(value != nil){
                for serviceId in value!{
                    listOfUnclaimedServices.append(serviceId as! String)
                }
                DataCurrentUser.loadServices1()

            }
            })
            { (error) in
                print(error.localizedDescription)
            }
    }
    
    class func loadInProgressServicesData(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child(userId).child("listOfInProgressServices").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSArray
            if(value != nil){
                for serviceId in value!{
                    print (serviceId)
                    listOfInProgressServices.append(serviceId as! String)
                }
                DataCurrentUser.loadServices2()
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    class func loadCompleteServicesData(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child(userId).child("listOfCompleteServices").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSArray
            if(value != nil){
                for serviceId in value!{
                    print (serviceId)
                    listOfCompleteServices.append(serviceId as! String)
                }
                DataCurrentUser.loadServices3()
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    class func loadOffersData(){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child(userId).child("listOfOffers").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print(value?.allKeys ?? "")
            if(value != nil){
                for serviceId in (value?.allValues)!{
                    listOfOffers.append(serviceId as! String)
                }
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    class func loadServices1(){
        unclaimedServices = []
        print("\(listOfUnclaimedServices.count)")
        for unclaimedServiceId in listOfUnclaimedServices{
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("unclaimed services").child(unclaimedServiceId).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                if(value != nil){
                    let type = value?.value(forKey: "type") as! String
                    let name = value?.value(forKey: "name") as! String
                    let description = value?.value(forKey: "description") as! String
                    let serviceId = value?.value(forKey: "serviceId") as! String
                    let userId = value?.value(forKey: "userId") as! String
                    let userPhone = value?.value(forKey: "userPhone") as! String
                    let userAddress = value?.value(forKey: "userAddress") as! String
                    let status = value?.value(forKey: "status") as! String
                    let serviceProviderId = value?.value(forKey: "serviceProviderId") as! String
                    unclaimedServices.append(Service(type: type, name: name, description: description, serviceId: serviceId, userId: userId, serviceProviderId: serviceProviderId, status: status, userPhone: userPhone, userAddress: userAddress))
                }
 
            })
            { (error) in
                print(error.localizedDescription)
            }
        }

        
        
        print("HH \(listOfUnclaimedServices)")
    }
    
    class func loadServices2(){

        inProgressServices = []

        for inProgressServiceId in listOfInProgressServices{
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("in progress services").child(inProgressServiceId).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                if(value != nil){
                    let type = value?.value(forKey: "type") as! String
                    let name = value?.value(forKey: "name") as! String
                    let description = value?.value(forKey: "description") as! String
                    let serviceId = value?.value(forKey: "serviceId") as! String
                    let userId = value?.value(forKey: "userId") as! String
                    let userPhone = value?.value(forKey: "userPhone") as! String
                    let userAddress = value?.value(forKey: "userAddress") as! String
                    let status = value?.value(forKey: "status") as! String
                    let serviceProviderId = value?.value(forKey: "serviceProviderId") as! String
                    
                    inProgressServices.append(Service(type: type, name: name, description: description, serviceId: serviceId, userId: userId, serviceProviderId: serviceProviderId, status: status, userPhone: userPhone, userAddress: userAddress))
                }
            })
            { (error) in
                print(error.localizedDescription)
            }
        }
        

        
        
        
    }
    
    class func loadServices3(){
        completeServices = []

        for completeServiceId in listOfCompleteServices{
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("complete services").child(completeServiceId).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                if(value != nil){
                    let type = value?.value(forKey: "type") as! String
                    let name = value?.value(forKey: "name") as! String
                    let description = value?.value(forKey: "description") as! String
                    let serviceId = value?.value(forKey: "serviceId") as! String
                    let userId = value?.value(forKey: "userId") as! String
                    let userPhone = value?.value(forKey: "userPhone") as! String
                    let userAddress = value?.value(forKey: "userAddress") as! String
                    let status = value?.value(forKey: "status") as! String
                    let serviceProviderId = value?.value(forKey: "serviceProviderId") as! String
                    
                    completeServices.append(Service(type: type, name: name, description: description, serviceId: serviceId, userId: userId, serviceProviderId: serviceProviderId, status: status, userPhone: userPhone, userAddress: userAddress))
                }
            })
            { (error) in
                print(error.localizedDescription)
            }
        }
        
        
        
    }
    
    class func deleteUnclaimedServiceLocally(service : Service){
        for index in 0..<unclaimedServices.count {
            if (unclaimedServices[index].serviceId == service.serviceId) {
                unclaimedServices.remove(at: index)
                break;
            }
        }
        print("The list before of unlcimed service are: \(listOfUnclaimedServices)")

        for index in 0..<listOfUnclaimedServices.count {
            if (listOfUnclaimedServices[index] == service.serviceId) {
                listOfUnclaimedServices.remove(at: index)
                break;
            }
        }
        print("The list after of unlcimed service are: \(listOfUnclaimedServices)")
        DataCurrentUser.updateListOfUnclaimedServices()
        
    }
    class func deleteUnclaimedServiceDatabase(service : Service){
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("unclaimed services").child(service.serviceId).removeValue()
        
    }
    
    class func updateListOfUnclaimedServices(){
        var ref2: DatabaseReference!
        ref2 = Database.database().reference()
        ref2.child("users").child(userId).child("listOfUnclaimedServices").removeValue()
        print("The count is: \(listOfUnclaimedServices.count)")
        for index in 0..<listOfUnclaimedServices.count {
            print("HI: \(index)+\(listOfUnclaimedServices[index])")
            ref2.root.child("users").child(user.userId).child("listOfUnclaimedServices").child("\(index)").setValue(listOfUnclaimedServices[index])
            
        }
    }
    
    
    class func clear(){
        user = User()
        userType = ""
        unclaimedServices = []
        listOfUnclaimedServices = []
        // offersServices = []
        inProgressServices = []
        completeServices = []
    }
    
}
