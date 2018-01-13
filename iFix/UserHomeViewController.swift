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
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCurrentUser.unclaimedServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let unclaimedCell = tableView.dequeueReusableCell(withIdentifier: "uncalimedServicesCell", for: indexPath) as! UnclaimedServicesTableViewCell
        unclaimedCell.serviceName.text = DataCurrentUser.unclaimedServices[indexPath.row].name
        unclaimedCell.serviceType.text = DataCurrentUser.unclaimedServices[indexPath.row].type
        unclaimedCell.serviceId = DataCurrentUser.unclaimedServices[indexPath.row].serviceId
        return unclaimedCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //try! Auth.auth().signOut()
    }

    @IBAction func logOut(_ sender: Any) {
        print(DataCurrentUser.unclaimedServices[0].name)
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
