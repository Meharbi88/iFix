//
//  UnclaimedServicesTableViewCell.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/12/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit

class UnclaimedServicesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var serviceName: UILabel!
    
    @IBOutlet weak var serviceType: UILabel!
    
    var serviceId : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func cancelRequest(_ sender: Any) {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
