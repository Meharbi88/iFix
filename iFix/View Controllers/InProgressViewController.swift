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
            
            return userInProgressCell
        }else{
            
            let serviceProviderInProgressCell = tableView.dequeueReusableCell(withIdentifier: "inProgressServicesForServiceProviderCell", for: indexPath) as! InProgressForServiceProviderTableViewCell
        
            serviceProviderInProgressCell.serviceName.text = DataCurrentServiceProvider.inProgressServices[indexPath.row].name
            
            return serviceProviderInProgressCell
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        inProgressTable.rowHeight = 220
        if(DataCurrentUser.userType=="User"){
            inProgressTable.rowHeight = 140
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
