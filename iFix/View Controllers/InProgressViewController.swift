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
    var refreshController = UIRefreshControl()

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
            userInProgressCell.serviceImage.image = UIImage(named: DataCurrentUser.inProgressServices[indexPath.row].type)
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
            
            userInProgressCell.price.text = "$\(DataCurrentUser.getOfferPriceFromOfferAccpted (offerId: DataCurrentUser.inProgressServices[indexPath.row].offerId))"
            // button
            userInProgressCell.didntShowUp.addTarget(self, action: #selector(didntShowUp), for: .touchUpInside)
            userInProgressCell.didntShowUp.tag = indexPath.row
            userInProgressCell.layer.cornerRadius = 15
            userInProgressCell.didntShowUp.layer.cornerRadius = 15
            userInProgressCell.layer.borderWidth = 2
            userInProgressCell.layer.shadowColor = UIColor.darkGray.cgColor
            userInProgressCell.layer.shadowOpacity = 5
            userInProgressCell.layer.borderColor = UIColor.darkGray.cgColor
            userInProgressCell.layer.masksToBounds = false
            return userInProgressCell
        }else{
            
            let serviceProviderInProgressCell = tableView.dequeueReusableCell(withIdentifier: "inProgressServicesForServiceProviderCell", for: indexPath) as! InProgressForServiceProviderTableViewCell
        
            serviceProviderInProgressCell.serviceName.text = DataCurrentServiceProvider.inProgressServices[indexPath.row].name
            serviceProviderInProgressCell.userAddress.text = DataCurrentServiceProvider.inProgressServices[indexPath.row].userAddress
            serviceProviderInProgressCell.userPhone.text = DataCurrentServiceProvider.inProgressServices[indexPath.row].userPhone
            serviceProviderInProgressCell.price.text = "$\(DataCurrentServiceProvider.getOfferPriceFromOfferAccpted (offerId: DataCurrentServiceProvider.inProgressServices[indexPath.row].offerId))"
            
            //button
            serviceProviderInProgressCell.cantMakeIt.addTarget(self, action: #selector(cantMakeIt), for: .touchUpInside)
            
            serviceProviderInProgressCell.cantMakeIt.tag = indexPath.row
            
            serviceProviderInProgressCell.serviceDone.addTarget(self, action: #selector(serviceDone), for: .touchUpInside)
            
            serviceProviderInProgressCell.serviceDone.tag = indexPath.row
            
            serviceProviderInProgressCell.layer.cornerRadius = 15
            serviceProviderInProgressCell.cantMakeIt.layer.cornerRadius = 15
            serviceProviderInProgressCell.serviceDone.layer.cornerRadius = 15
            serviceProviderInProgressCell.layer.borderWidth = 2
            serviceProviderInProgressCell.layer.shadowColor = UIColor.darkGray.cgColor
            serviceProviderInProgressCell.layer.shadowOpacity = 5
            serviceProviderInProgressCell.layer.borderColor = UIColor.darkGray.cgColor
            serviceProviderInProgressCell.layer.masksToBounds = false
            return serviceProviderInProgressCell
        }

    }
    
    @objc func didntShowUp(sender: UIButton){
        showAlertDidntShowUpConfirmation(service : DataCurrentUser.inProgressServices[sender.tag]);
    }
    
    func showAlertDidntShowUpConfirmation(service : Service){
        let title = "Did Not Show Up"
        let message = "You are about to cancel an accepted offer for your service id: \(service.serviceId)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Confirm", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            self.cancelForNotShowingUP(service: service)

        })
        let actionNo = UIAlertAction(title: "Back", style: .cancel , handler:nil)
        
        alertController.addAction(actionYes)
        alertController.addAction(actionNo)
        present(alertController, animated: true, completion: nil)
    }
    
    func cancelForNotShowingUP(service: Service){
        let offerId = service.offerId
        service.offerId = ""
        service.serviceProviderId = ""
        service.status = "unclaimed"
        
        DeleteData.deleteOffer(offerId: offerId)
        DataCurrentUser.deleteInProgressServiceLocally(service: service)
        DataCurrentUser.deleteInProgressServiceData(service: service)
        DataCurrentUser.addUnclaimedServicesLocally(service: service)
        DataCurrentUser.addUnclaimedServicesData(service: service)
        inProgressTable.reloadData()
    }
    
    @objc func cantMakeIt(sender: UIButton){
        showAlertCantMakeItConfirmation(service : DataCurrentServiceProvider.inProgressServices[sender.tag]);
    }
    
    func showAlertCantMakeItConfirmation(service : Service){
        let title = "Can't Make It"
        let message = "Your accepted offer for service id : \(service.serviceId) will be discard, are you sure you want to proceed?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Confirm", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            self.discardAcceptedOffer(service: service)
        })
        let actionNo = UIAlertAction(title: "Back", style: .cancel , handler:nil)
        
        alertController.addAction(actionYes)
        alertController.addAction(actionNo)
        present(alertController, animated: true, completion: nil)
    }
    
    func discardAcceptedOffer(service: Service){
        let offerId = service.offerId
        service.offerId = ""
        service.serviceProviderId = ""
        service.status = "unclaimed"
        
        DeleteData.deleteOffer(offerId: offerId)
        DataCurrentServiceProvider.deleteInProgressServiceLocally(service: service)
        DataCurrentServiceProvider.deleteInProgressServiceData(service: service)
        DataCurrentServiceProvider.addUnclaimedServicesLocally(service: service)
        DataCurrentServiceProvider.addUnclaimedServicesData(service: service)
        inProgressTable.reloadData()
    }
    
    @objc func serviceDone(sender: UIButton){
        showAlertServiceDoneConfirmation(service : DataCurrentServiceProvider.inProgressServices[sender.tag]);
    }
    
    func showAlertServiceDoneConfirmation(service : Service){
        let title = "Complete Service Confirmation"
        let message = "Congratulation!\nYou have completed service id : \(service.serviceId), please confirm"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Confirm", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            self.completedService(service: service)
        })
        let actionNo = UIAlertAction(title: "Back", style: .cancel , handler:nil)
        
        alertController.addAction(actionYes)
        alertController.addAction(actionNo)
        present(alertController, animated: true, completion: nil)
    }
    
    func completedService(service: Service){
        service.status = "complete"
        DataCurrentServiceProvider.deleteInProgressServiceLocally(service: service)
        DataCurrentServiceProvider.deleteInProgressServiceData(service: service)
        DataCurrentServiceProvider.addCompleteServicesLocally(service: service)
        DataCurrentServiceProvider.addCompleteServicesData(service: service)
        inProgressTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        inProgressTable.rowHeight = 180
        if(DataCurrentUser.userType=="User"){
            inProgressTable.rowHeight = 188
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
        
        inProgressTable.refreshControl = self.refreshController
        self.refreshController.attributedTitle = NSAttributedString(string: "Last update was on \(NSDate())")
        self.refreshController.backgroundColor = UIColor.lightGray
        self.refreshController.addTarget(self, action: #selector(OffersViewController.didRefresh), for: .valueChanged)
    }
    
    @objc func didRefresh(){
        refreshController.beginRefreshing()
        if(DataCurrentUser.userType=="User"){
            DataCurrentUser.loadInProgressServicesData()
            
        }else{
            DataCurrentServiceProvider.loadInProgressServicesData()
        }
        
        //refreshController.endRefreshing()
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        refreshController.endRefreshing()
        inProgressTable.reloadData()
        
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
