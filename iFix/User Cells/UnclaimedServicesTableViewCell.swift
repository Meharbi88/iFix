//
//  UnclaimedServicesTableViewCell.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/12/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import UIKit

class UnclaimedServicesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var numberOfOffers: UILabel!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    var pressCancel: String = "11"
    var serviceId : String = ""

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
