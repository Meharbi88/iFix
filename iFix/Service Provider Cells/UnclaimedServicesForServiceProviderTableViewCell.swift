//
//  UnclaimedServicesForServiceProviderTableViewCell.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/15/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit

class UnclaimedServicesForServiceProviderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var serviceName: UILabel!
    
    @IBOutlet weak var serviceDescription: UITextView!
    
    @IBOutlet weak var userLocation: UILabel!
    
    @IBAction func makeOffer(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
