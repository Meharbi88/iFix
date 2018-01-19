//
//  UserHomeViewController.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/3/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit
import Firebase

class UserHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var topBar: UINavigationBar!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var requestAService: UIBarButtonItem!
   
    var serviceId : String = "HIUserHomeViewController"
    var refreshController = UIRefreshControl()
    //let cellSpacingHeight: CGFloat = 5
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(DataCurrentUser.userType=="User"){
            return DataCurrentUser.unclaimedServices.count
        }else{
            return DataCurrentServiceProvider.unclaimedServices.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(DataCurrentUser.userType=="User"){
            let unclaimedCell = tableView.dequeueReusableCell(withIdentifier: "unclaimedServicesCell", for: indexPath) as! UnclaimedServicesTableViewCell
            unclaimedCell.serviceName.text = DataCurrentUser.unclaimedServices[indexPath.row].name
            unclaimedCell.serviceType.text = DataCurrentUser.unclaimedServices[indexPath.row].type
            unclaimedCell.serviceId = DataCurrentUser.unclaimedServices[indexPath.row].serviceId
            unclaimedCell.cancelButton.addTarget(self, action: #selector(cancelRequest), for: .touchUpInside)
            unclaimedCell.cancelButton.tag = indexPath.row
            
            unclaimedCell.layer.cornerRadius = 15
            unclaimedCell.cancelButton.layer.cornerRadius = 15
            unclaimedCell.cancelButton.layer.borderWidth = 2
            unclaimedCell.layer.borderWidth = 2
            unclaimedCell.layer.shadowColor = UIColor.darkGray.cgColor
            unclaimedCell.layer.shadowOpacity = 5
            unclaimedCell.layer.borderColor = UIColor.darkGray.cgColor
            unclaimedCell.layer.masksToBounds = false
            return unclaimedCell
            
        }else{
            let unclaimedCellForServiceProvider = tableView.dequeueReusableCell(withIdentifier: "unclaimedServicesForServiceProviderCell", for: indexPath) as! UnclaimedServicesForServiceProviderTableViewCell
            unclaimedCellForServiceProvider.serviceName.text = DataCurrentServiceProvider.unclaimedServices[indexPath.row].name
            unclaimedCellForServiceProvider.userLocation.text = DataCurrentServiceProvider.unclaimedServices[indexPath.row].userAddress
            unclaimedCellForServiceProvider.serviceDescription.text = DataCurrentServiceProvider.unclaimedServices[indexPath.row].description
            unclaimedCellForServiceProvider.makeOffer.addTarget(self, action: #selector(self.makeOffer), for: .touchUpInside)
            unclaimedCellForServiceProvider.makeOffer.tag = indexPath.row
            
            unclaimedCellForServiceProvider.layer.cornerRadius = 15
            unclaimedCellForServiceProvider.makeOffer.layer.cornerRadius = 15
            unclaimedCellForServiceProvider.makeOffer.layer.borderWidth = 2
            unclaimedCellForServiceProvider.makeOffer.layer.borderColor = UIColor.black.cgColor
            unclaimedCellForServiceProvider.layer.borderWidth = 2
            unclaimedCellForServiceProvider.layer.shadowColor = UIColor.darkGray.cgColor
            unclaimedCellForServiceProvider.layer.shadowOpacity = 5
            unclaimedCellForServiceProvider.layer.borderColor = UIColor.darkGray.cgColor
            unclaimedCellForServiceProvider.layer.masksToBounds = false
            return unclaimedCellForServiceProvider
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return cellSpacingHeight
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTable.reloadData()
        myTable.refreshControl = self.refreshController
        self.refreshController.attributedTitle = NSAttributedString(string: "Last update was on \(NSDate())")
        self.refreshController.backgroundColor = UIColor.lightGray
        self.refreshController.addTarget(self, action: #selector(UserHomeViewController.didRefresh), for: .valueChanged)
        
    }
    
    @objc func didRefresh(){
        refreshController.beginRefreshing()
        print("1\(DataCurrentUser.unclaimedServices)")
        if(DataCurrentUser.userType=="User"){
            DataCurrentUser.loadUnclaimedServicesData()

        }else{
            DataCurrentServiceProvider.loadUnclaimedServicesData()
        }

        //refreshController.endRefreshing()

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        refreshController.endRefreshing()
        myTable.reloadData()

    }
    


    override func viewDidAppear(_ animated: Bool) {
        myTable.rowHeight = 220
        if(DataCurrentUser.userType=="User"){
            myTable.rowHeight = 140
            topBar.topItem?.rightBarButtonItem?.customView?.isHidden = false
        }
        myTable.reloadData()
    }
    
    @objc func cancelRequest(sender: UIButton){
        showAlertConfirmation(service : DataCurrentUser.unclaimedServices[sender.tag]);
    }
    
    func showAlertConfirmation(service : Service){
        let title = "Cancel Request"
        let message = "Are you sure you want to cancel your service request?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Yes", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("offers").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let key = snapshot.value as? NSDictionary
                if (key != nil){
                    for value in (key?.allValues)!{
                        let value2 = value as! NSDictionary
                        if((value2.value(forKey: "serviceId") as! String) == service.serviceId){
                            let offerId = value2.value(forKey: "offerId") as! String
                            DeleteData.deleteOffer(offerId: offerId)
                            DataCurrentUser.deleteOfferLocally(offerId: offerId)
                        }
                    }
                }
            })
            { (error) in
                self.deleteService(service: service)
                print(error.localizedDescription)
            }
            self.deleteService(service: service)
        })
        let actionNo = UIAlertAction(title: "No", style: .cancel , handler:nil)
        
        alertController.addAction(actionYes)
        alertController.addAction(actionNo)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    func deleteService(service : Service) {
        DataCurrentUser.deleteUnclaimedServiceLocally(service: service)
        DataCurrentUser.deleteUnclaimedServiceData(service: service)
        myTable.reloadData()
    }
    
    @objc func makeOffer(sender: UIButton){
        showOfferDialog(service : DataCurrentServiceProvider.unclaimedServices[sender.tag]);
    }

    func showOfferDialog(service : Service){
        let title = "Make Offer"
        let message = "You are about to make offer for \(service.name) for the following price:"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        let actionSubmit = UIAlertAction(title: "Make Offer", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            let price = alertController.textFields?[0].text
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("unclaimed services").child(service.serviceId).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let key = snapshot.value as? NSDictionary
                if (key != nil){
                    self.createOffer(service : service, price : price!)
                }else{
                    DataCurrentServiceProvider.loadUnclaimedServicesData()
                    self.showAlertNotExistAntmore()
                }
            })
            { (error) in
                print(error.localizedDescription)
                DataCurrentServiceProvider.loadUnclaimedServicesData()
                self.showAlertNotExistAntmore()
            }
        })
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel , handler:nil)
        
        alertController.addAction(actionSubmit)
        alertController.addAction(actionCancel)
        alertController.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Enter Your Price"
            textField.keyboardType = .numberPad

        })
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertNotExistAntmore(){
        let title = "Error"
        let message = "The service has been canceled"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionOk = UIAlertAction(title: "OK", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            self.myTable.reloadData()
        })

        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }

    
    func createOffer(service: Service, price: String){
        let offer : Offer = Offer(offerId: RandomGenerator.randomOfferID(), price: price, serviceId : service.serviceId, userId: service.userId, state: "undetermined", serviceProviderId: DataCurrentServiceProvider.serviceProviderId)
        DataCurrentServiceProvider.undeterminedOffers.append(offer)
        WriteData.writeOffer(offer:offer)
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        DataCurrentUser.clear()
        DataCurrentServiceProvider.clear()
        try! Auth.auth().signOut()
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
