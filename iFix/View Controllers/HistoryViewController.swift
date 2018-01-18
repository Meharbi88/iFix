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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCurrentUser.completeServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let completeCell = tableView.dequeueReusableCell(withIdentifier: "completeServiceCell", for: indexPath) as! CompleteTableViewCell
        
        completeCell.serviceName.text = DataCurrentUser.completeServices[indexPath.row].name
        completeCell.serviceType.text = DataCurrentUser.completeServices[indexPath.row].type
        
        return completeCell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        completeTable.rowHeight = 220
        if(DataCurrentUser.userType=="User"){
            completeTable.rowHeight = 140
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
