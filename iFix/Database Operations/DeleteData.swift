//
//  DeleteData.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/17/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import Foundation
import Firebase

class DeleteData {

    class func deleteService(serviceId :String, serviceState: String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child(serviceState).child(serviceId).removeValue()
    }
    
    class func deleteOffer(offerId :String) {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("offers").child(offerId).removeValue()
    }
    
    
}
