//
//  InProgressViewController.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/12/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit
import Firebase
class InProgressViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topBar: UINavigationBar!
    @IBOutlet weak var inProgressTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(DataCurrentUser.userType=="User"){
            return DataCurrentUser.inProgressServices.count
        }else{
            return DataCurrentServiceProvider.inProgressServices.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(DataCurrentUser.userType=="User"){
            let userInProgressCell = tableView.dequeueReusableCell(withIdentifier: "inProgressServicesCell", for: indexPath) as! InProgressTableViewCell

            userInProgressCell.serviceName.text = DataCurrentUser.inProgressServices[indexPath.row].name
            
            userInProgressCell.serviceType.text = DataCurrentUser.inProgressServices[indexPath.row].type
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("serviceProviders").child(DataCurrentUser.inProgressServices[indexPath.row].serviceProviderId).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                if(value != nil){
                    let firstName = value?.value(forKey: "firstName") as! String
                    let lastName = value?.value(forKey: "lastName") as! String
                    userInProgressCell.serviceProviderName.text = "\(firstName) \(lastName)"
                }
            })
            { (error) in
                print(error.localizedDescription)
            }
            
            userInProgressCell.price.text = DataCurrentUser.getOfferPriceFromOfferAccpted (offerId: DataCurrentUser.inProgressServices[indexPath.row].offerId)
            // button
            return userInProgressCell
        }else{
            
            let serviceProviderInProgressCell = tableView.dequeueReusableCell(withIdentifier: "inProgressServicesForServiceProviderCell", for: indexPath) as! InProgressForServiceProviderTableViewCell
        
            serviceProviderInProgressCell.serviceName.text = DataCurrentServiceProvider.inProgressServices[indexPath.row].name
            serviceProviderInProgressCell.userAddress.text = DataCurrentServiceProvider.inProgressServices[indexPath.row].userAddress
            serviceProviderInProgressCell.userPhone.text = DataCurrentServiceProvider.inProgressServices[indexPath.row].userPhone
            serviceProviderInProgressCell.price.text = DataCurrentServiceProvider.getOfferPriceFromOfferAccpted (offerId: DataCurrentServiceProvider.inProgressServices[indexPath.row].offerId)
            
            //button
            return serviceProviderInProgressCell
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        inProgressTable.rowHeight = 224
        if(DataCurrentUser.userType=="User"){
            inProgressTable.rowHeight = 224
            topBar.topItem?.rightBarButtonItem?.customView?.isHidden = false
        }
        inProgressTable.reloadData()
    }
    

    
    @IBAction func logOut(_ sender: Any) {
        DataCurrentUser.clear()
        DataCurrentServiceProvider.clear()
        try! Auth.auth().signOut()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inProgressTable.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
