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
    var pressCancel: String = "11"
    @IBOutlet weak var cancelButton: UIButton!
    
    var serviceId : String = ""
    
//    @IBAction func cancelRequest(_ sender: Any) {
//        print(serviceId)
//        pressCancel = serviceId
//        print(pressCancel)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func showAlertConfirmation(){
//        let title = "Cancel Request"
//        let message = "Are you sure you want to cancel your service request?"
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let actionYes = UIAlertAction(title: "Yes", style: .default , handler: {
//            (alert: UIAlertAction!) -> Void in
//            self.deleteService()
//            self.updateDatabase()
//        })
//        let actionNo = UIAlertAction(title: "No", style: .cancel , handler:nil)
//
//        alertController.addAction(actionYes)
//        alertController.addAction(actionNo)
//        UserHomeViewController.init()..present(alertController, animated: true, completion: nil)
//    }
//
//    func deleteService() {
////        for index in 0..<DataCurrentServiceProvider.unclaimedServices.count {
////            if DataCurrentServiceProvider.unclaimedServices[index].serviceId == serviceId {
////                DataCurrentServiceProvider.unclaimedServices.remove(at: index)
////            }
////        }
//    }
//
//    func updateDatabase() {
//
//    }

}
