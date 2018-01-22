//
//  Download.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/22/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//


import Foundation
import Firebase

class DownloadData{
    
    class func downloadUserProfileImage(userId: String){
        let imageName = userId
        let storageReference = Storage.storage().reference().child("\(imageName).png")
        storageReference.getData(maxSize: 1 * 2096 * 2096) { (data, error) in
            if let error = error {
                print("Couldn't download \(error)")
            }else{
                print("Load Image success")
                DataCurrentUser.image = UIImage(data: data!)
            }
        }
    }
    
    class func downloadServiceProviderProfileImage(serviceProviderId : String){
        
        
        let imageName = serviceProviderId
        let storageReference = Storage.storage().reference().child("\(imageName).png")
        storageReference.getData(maxSize: 1 * 2096 * 2096) { (data, error) in
            if let error = error {
                print("Couldn't download \(error)")
            }else{
                print("Load Image success")
                DataCurrentServiceProvider.image = UIImage(data: data!)
            }
        }
    }
    
}
