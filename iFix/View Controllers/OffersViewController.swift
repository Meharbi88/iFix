//
//  OffersViewController.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/12/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit
import Firebase

class OffersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var topBar: UINavigationBar!
    @IBOutlet weak var offersTable: UITableView!
    var refreshController = UIRefreshControl()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(DataCurrentUser.userType=="User"){
            return DataCurrentUser.undeterminedOffers.count
        }else{
            return DataCurrentServiceProvider.undeterminedOffers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(DataCurrentUser.userType=="User"){
            let userOfferCell = tableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as! OfferTableViewCell
            userOfferCell.serviceName.text = DataCurrentUser.getServiceFromUnclaimedServices(serviceId: DataCurrentUser.undeterminedOffers[indexPath.row].serviceId)?.name
            userOfferCell.serviceType.text = DataCurrentUser.getServiceFromUnclaimedServices(serviceId: DataCurrentUser.undeterminedOffers[indexPath.row].serviceId)?.type
            userOfferCell.price.text = "$\(DataCurrentUser.undeterminedOffers[indexPath.row].price)"
            
            userOfferCell.acceptOffer.addTarget(self, action: #selector(acceptOffer), for: .touchUpInside)
            userOfferCell.acceptOffer.tag = indexPath.row
            
            userOfferCell.declineOffer.addTarget(self, action: #selector(declineOffer), for: .touchUpInside)
            userOfferCell.declineOffer.tag = indexPath.row
            
            userOfferCell.serviceImage.image = UIImage(named: (DataCurrentUser.getServiceFromUnclaimedServices(serviceId: DataCurrentUser.undeterminedOffers[indexPath.row].serviceId)?.type)!)
            
            userOfferCell.layer.cornerRadius = 15
            userOfferCell.acceptOffer.layer.cornerRadius = 15
            userOfferCell.declineOffer.layer.cornerRadius = 15
            userOfferCell.layer.borderWidth = 2
            userOfferCell.layer.shadowColor = UIColor.darkGray.cgColor
            userOfferCell.layer.shadowOpacity = 5
            userOfferCell.layer.borderColor = UIColor.darkGray.cgColor
            userOfferCell.layer.masksToBounds = false
            
            return userOfferCell
        }else{
            let serviceProviderOfferCell = tableView.dequeueReusableCell(withIdentifier: "offerServiceProviderCell", for: indexPath) as! OffersForServiceProviderTableViewCell
            serviceProviderOfferCell.serviceName.text = DataCurrentServiceProvider.getServiceFromUnclaimedServices(serviceId: DataCurrentServiceProvider.undeterminedOffers[indexPath.row].serviceId)?.name
            
            serviceProviderOfferCell.serviceType.text = DataCurrentServiceProvider.getServiceFromUnclaimedServices(serviceId: DataCurrentServiceProvider.undeterminedOffers[indexPath.row].serviceId)?.type
            
            serviceProviderOfferCell.price.text = "$\(DataCurrentServiceProvider.undeterminedOffers[indexPath.row].price)"
            
            serviceProviderOfferCell.cancelOffer.addTarget(self, action: #selector(cancelOffer), for: .touchUpInside)
            serviceProviderOfferCell.cancelOffer.tag = indexPath.row
            serviceProviderOfferCell.layer.cornerRadius = 15
            serviceProviderOfferCell.cancelOffer.layer.cornerRadius = 15
            serviceProviderOfferCell.layer.borderWidth = 2
            serviceProviderOfferCell.layer.shadowColor = UIColor.darkGray.cgColor
            serviceProviderOfferCell.layer.shadowOpacity = 5
            serviceProviderOfferCell.layer.borderColor = UIColor.darkGray.cgColor
            serviceProviderOfferCell.layer.masksToBounds = false
            return serviceProviderOfferCell
        }
    }
    
    
    @objc func acceptOffer(sender: UIButton){
        showAlertAcceptConfirmation(offer : DataCurrentUser.undeterminedOffers[sender.tag]);
    }
    
    func showAlertAcceptConfirmation(offer : Offer){
        let title = "Accept Offer"
        let message = "You are about to accept an offer for your service request id: \(offer.serviceId) for price $\(offer.price)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Confirm", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            self.offerAccepted(offer : offer)
            //check off in the database if existed processed
            // if not delete offer
            
        })
        let actionNo = UIAlertAction(title: "Back", style: .cancel , handler:nil)
        
        alertController.addAction(actionYes)
        alertController.addAction(actionNo)
        present(alertController, animated: true, completion: nil)
    }
    func offerAccepted(offer: Offer){
        let service : Service = DataCurrentUser.getServiceFromUnclaimedServices(serviceId: offer.serviceId)!
        offer.state = "accepted"
        service.status = "in progress"
        service.offerId = offer.offerId
        service.serviceProviderId = offer.serviceProviderId
        DataCurrentUser.updateOfferAcceptedLocally(offer : offer, service : service)
        DataCurrentUser.updateOfferAcceptedDatabase(offer : offer, service: service)
        // delete other offers that still reviewing under this service beacuse one offer approved
        offersTable.reloadData()
    }
    
    @objc func declineOffer(sender: UIButton){
        showAlertDeclineConfirmation(offer : DataCurrentUser.undeterminedOffers[sender.tag]);
    }
    
    func showAlertDeclineConfirmation(offer : Offer){
        let title = "Decline Offer"
        let message = "You are about to decline an offer for your service request id: \(offer.serviceId) for price $\(offer.price)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Confirm", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            self.offerDeclined(offer: offer)
            //check off in the database if existed processed
            // if not delete offer
        })
        let actionNo = UIAlertAction(title: "Back", style: .cancel , handler:nil)
        
        alertController.addAction(actionYes)
        alertController.addAction(actionNo)
        present(alertController, animated: true, completion: nil)
    }
    
    func offerDeclined(offer: Offer){
        offer.state = "declined"
        DataCurrentUser.updateOfferDeclinedLocally(offer : offer)
        DataCurrentUser.updateOfferDeclinedDatabase(offer : offer)
        offersTable.reloadData()
    }
    
    @objc func cancelOffer(sender: UIButton){
        showAlertCancelConfirmation(offer : DataCurrentServiceProvider.undeterminedOffers[sender.tag]);
    }
    
    func showAlertCancelConfirmation(offer : Offer){
        let title = "Cancel Offer"
        let message = "Are you sure you want to cancel your offer?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Yes", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            self.deleteOffer(offer: offer)
            // check if the offer is undetermined if yes delete otherwise. the service is in progress please check the service list.
        })
        let actionNo = UIAlertAction(title: "No", style: .cancel , handler:nil)
        
        alertController.addAction(actionYes)
        alertController.addAction(actionNo)
        present(alertController, animated: true, completion: nil)
    }
    
    func deleteOffer(offer : Offer) {
        DataCurrentServiceProvider.deleteUndeterminedOffersLocally(offer: offer)
        DataCurrentServiceProvider.deleteOfferData(offer: offer)
        offersTable.reloadData()
    }
    
    
    @IBAction func logOut(_ sender: Any) {
        DataCurrentUser.clear()
        DataCurrentServiceProvider.clear()
        try! Auth.auth().signOut()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        offersTable.rowHeight = 149
        if(DataCurrentUser.userType=="User"){
            offersTable.rowHeight = 155
            topBar.topItem?.rightBarButtonItem?.customView?.isHidden = false
        }
        offersTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offersTable.reloadData()
        offersTable.refreshControl = self.refreshController
        self.refreshController.attributedTitle = NSAttributedString(string: "Last update was on \(NSDate())")
        self.refreshController.backgroundColor = UIColor.lightGray
        self.refreshController.addTarget(self, action: #selector(OffersViewController.didRefresh), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    
    @objc func didRefresh(){
        refreshController.beginRefreshing()
        if(DataCurrentUser.userType=="User"){
            DataCurrentUser.loadOffersData()
            
        }else{
            DataCurrentServiceProvider.loadOffersData()
        }
        
        //refreshController.endRefreshing()
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        refreshController.endRefreshing()
        offersTable.reloadData()
        
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
