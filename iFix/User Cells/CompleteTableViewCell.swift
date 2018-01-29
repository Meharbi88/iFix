//
//  CompleteTableViewCell.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/15/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import UIKit

class CompleteTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var serviceName: UILabel!
    
    @IBOutlet weak var serviceType: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
