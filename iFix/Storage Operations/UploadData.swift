//
//  Upload.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/22/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import Foundation
import Firebase

class UploadData {
    
    class func uploadUserOrServiceProviderProfileImage(imageName: String, image: UIImage?){
        let storageReference = Storage.storage().reference().child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(image!){
            storageReference.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print("Couldn't upload data")
                    return
                }
                if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                    print(profileImageURL)
                }
            })
        }
    }
    
}
