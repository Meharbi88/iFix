//
//  ServiceRequestViewController.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/12/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit

class ServiceRequestViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var serviceName: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    
    @IBOutlet weak var userAddress: UITextField!
    @IBOutlet weak var serviceDescription: UITextView!
    let sub = ["Plumping", "Cars", "Home Appliances", "Electricity", "Electronic Devices", "Smart Phones"]
    
    @IBAction func serivceRequestSubmit(_ sender: Any) {
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sub.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sub[row]
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
