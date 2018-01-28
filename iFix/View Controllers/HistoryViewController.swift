//
//  HistoryViewController.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/12/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var completeTable: UITableView!
    @IBOutlet weak var topBar: UINavigationBar!
    var refreshController = UIRefreshControl()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(DataCurrentUser.userType=="User"){
            return DataCurrentUser.completeServices.count
        }else{
            return DataCurrentServiceProvider.completeServices.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(DataCurrentUser.userType=="User"){
            let userCompleteCell = tableView.dequeueReusableCell(withIdentifier: "completeServicesCell", for: indexPath) as! CompleteTableViewCell
            
            userCompleteCell.serviceImage.image = UIImage(named: DataCurrentUser.completeServices[indexPath.row].type)
            
            userCompleteCell.serviceName.text = DataCurrentUser.completeServices[indexPath.row].name
            
            userCompleteCell.serviceType.text = DataCurrentUser.completeServices[indexPath.row].type
            
            userCompleteCell.price.text = "$\(DataCurrentUser.getOfferPriceFromOfferAccpted (offerId: DataCurrentUser.completeServices[indexPath.row].offerId))"
            
            userCompleteCell.layer.cornerRadius = 15
            userCompleteCell.layer.borderWidth = 2
            userCompleteCell.layer.shadowColor = UIColor.darkGray.cgColor
            userCompleteCell.layer.shadowOpacity = 5
            userCompleteCell.layer.borderColor = UIColor.darkGray.cgColor
            userCompleteCell.layer.masksToBounds = false
            
            return userCompleteCell
            
        }else{
            
            let serviceProviderCompleteCell = tableView.dequeueReusableCell(withIdentifier: "completeServicesForServiceProviderCell", for: indexPath) as! CompleteForServiceProviderTableViewCell
            
            serviceProviderCompleteCell.serviceName.text = DataCurrentServiceProvider.completeServices[indexPath.row].name

            serviceProviderCompleteCell.price.text = "$\(DataCurrentServiceProvider.getOfferPriceFromOfferAccpted (offerId: DataCurrentServiceProvider.completeServices[indexPath.row].offerId))"
            
            serviceProviderCompleteCell.layer.cornerRadius = 15
            serviceProviderCompleteCell.layer.borderWidth = 2
            serviceProviderCompleteCell.layer.shadowColor = UIColor.darkGray.cgColor
            serviceProviderCompleteCell.layer.shadowOpacity = 5
            serviceProviderCompleteCell.layer.borderColor = UIColor.darkGray.cgColor
            serviceProviderCompleteCell.layer.masksToBounds = false
            
            return serviceProviderCompleteCell
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        completeTable.rowHeight = 72
        if(DataCurrentUser.userType=="User"){
            completeTable.rowHeight = 106
            topBar.topItem?.rightBarButtonItem?.customView?.isHidden = false
        }
        completeTable.reloadData()
    }
    
    @IBAction func logOut(_ sender: Any) {
        DataCurrentUser.clear()
        DataCurrentServiceProvider.clear()
        try! Auth.auth().signOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeTable.reloadData()
        // Do any additional setup after loading the view.
        
        completeTable.refreshControl = self.refreshController
        self.refreshController.attributedTitle = NSAttributedString(string: "Last update was on \(NSDate())")
        self.refreshController.backgroundColor = UIColor.lightGray
        self.refreshController.addTarget(self, action: #selector(OffersViewController.didRefresh), for: .valueChanged)
    }
    
 

    @objc func didRefresh(){
        refreshController.beginRefreshing()
        if(DataCurrentUser.userType=="User"){
            DataCurrentUser.loadCompleteServicesData()
        }else{
            DataCurrentServiceProvider.loadCompleteServicesData()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        refreshController.endRefreshing()
        completeTable.reloadData()
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
