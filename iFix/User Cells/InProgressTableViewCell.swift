//
//  InProgressTableViewCell.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/15/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit

class InProgressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var serviceProviderName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var didntShowUp: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
