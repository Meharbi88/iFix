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
    static var unclaimedServices : [Service] = []
    //static var offersServices : [Offer] = []
    //static var inProgressServices : [Service] = []
    //static var historyServices : [Service] = []
    
    class func loadUnclimedData() -> Bool{
        unclaimedServices = []
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child(userId).child("services").child("unclaimed").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print(value?.allKeys ?? "")
            if(value != nil){
            for serviceId in (value?.allKeys)!{
                let value2 = snapshot.childSnapshot(forPath: serviceId as! String).value as? NSDictionary
                print (value2?.allKeys ?? "")
                let type = (value2 as AnyObject).value(forKey: "type") as! String
                let name = (value2 as AnyObject).value(forKey: "name") as! String
                let description = (value2 as AnyObject).value(forKey: "description") as! String
                let serviceId = (value2 as AnyObject).value(forKey: "serviceId") as! String
                let userId = (value2 as AnyObject).value(forKey: "userId") as! String
                let userPhone = (value2 as AnyObject).value(forKey: "userPhone") as! String
                let userAddress = (value2 as AnyObject).value(forKey: "userAddress") as! String
                let status = (value2 as AnyObject).value(forKey: "serviceStatus") as! String
                let service = Service(type: type, name: name, description: description, userId: userId, userPhone: userPhone, userAddress: userAddress)
                service.serviceId = serviceId
                service.status = status
                unclaimedServices.append(service)
            }
            }
            })
        { (error) in
            print(error.localizedDescription)
        }
        return true
    }
    
    
}
