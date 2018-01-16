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
    
    @IBOutlet weak var inProgressTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCurrentUser.inProgressServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inProgressCell = tableView.dequeueReusableCell(withIdentifier: "inProgressServiceCell", for: indexPath) as! InProgressTableViewCell
        
        inProgressCell.serviceName.text = DataCurrentUser.inProgressServices[indexPath.row].name
        inProgressCell.serviceType.text = DataCurrentUser.inProgressServices[indexPath.row].type
        
        return inProgressCell
    }
    

    
    @IBAction func logOut(_ sender: Any) {
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
