//
//  RandomGenerator.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/14/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import Foundation

class RandomGenerator{
    
    class func randomServiceID() -> String {
        
        let a = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        var s = ""
    
        for _ in 0..<10{
            
            let r = Int(arc4random_uniform(UInt32(a.count)))
            s += String(a[a.index(a.startIndex, offsetBy: r)])
    
        }
    
        return s
    }
    class func randomOfferID() -> String {
        
        let a = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        var s = ""
        
        for _ in 0..<12{
            
            let r = Int(arc4random_uniform(UInt32(a.count)))
            s += String(a[a.index(a.startIndex, offsetBy: r)])
            
        }
        
        return s
    }
}
