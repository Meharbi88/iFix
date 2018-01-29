//
//  InProgressForServiceProviderTableViewCell.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/18/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import UIKit

class InProgressForServiceProviderTableViewCell: UITableViewCell {

    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var cantMakeIt: UIButton!
    @IBOutlet weak var serviceDone: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
