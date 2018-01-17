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
            
            return unclaimedCell
        }else{
            let unclaimedCellForServiceProvider = tableView.dequeueReusableCell(withIdentifier: "unclaimedServicesForServiceProviderCell", for: indexPath) as! UnclaimedServicesForServiceProviderTableViewCell
            unclaimedCellForServiceProvider.serviceName.text = DataCurrentServiceProvider.unclaimedServices[indexPath.row].name
            unclaimedCellForServiceProvider.userLocation.text = DataCurrentServiceProvider.unclaimedServices[indexPath.row].userAddress
            unclaimedCellForServiceProvider.serviceDescription.text = DataCurrentServiceProvider.unclaimedServices[indexPath.row].description
            return unclaimedCellForServiceProvider
        }
    }
    
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

        self.refreshController.endRefreshing()
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
        print(DataCurrentUser.unclaimedServices[sender.tag].serviceId)
        showAlertConfirmation(service : DataCurrentUser.unclaimedServices[sender.tag]);
    }
    
    func showAlertConfirmation(service : Service){
        let title = "Cancel Request"
        let message = "Are you sure you want to cancel your service request?"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Yes", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            self.deleteService(service: service)
        })
        let actionNo = UIAlertAction(title: "No", style: .cancel , handler:nil)
        
        alertController.addAction(actionYes)
        alertController.addAction(actionNo)
        present(alertController, animated: true, completion: nil)
    }
    
    func deleteService(service : Service) {
        print("The list before2 of unlcimed service are: \(DataCurrentUser.listOfUnclaimedServices)")
        DataCurrentUser.deleteUnclaimedServiceLocally(service: service)
        DataCurrentUser.deleteUnclaimedServiceDatabase(service: service)
        print("The list after2 of unlcimed service are: \(DataCurrentUser.listOfUnclaimedServices)")
        DataCurrentUser.updateListOfUnclaimedServices()

//        updateDatabase()
        myTable.reloadData()
    }
    
//    func updateDatabase() {
//        DataCurrentUser.updateListOfUnclaimedServices()
//    }
    
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
