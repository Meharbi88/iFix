//
//  ServiceRequestViewController.swift
//  iFix
//
//  Created by Fahad Alharbi on 1/12/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit
import Firebase

class ServiceRequestViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var serviceName: UITextField!
    @IBOutlet weak var userPhoneNumber: UITextField!
    @IBOutlet weak var userAddress: UITextField!
    @IBOutlet weak var serviceDescription: UITextView!
    @IBOutlet weak var serviceTypesPicker: UIPickerView!
    
    var type : String = "Plumping"
    
    let sub = ["Plumping", "Cars", "Home Appliances", "Electricity", "Electronic Devices", "Smart Phones"]
    
    @IBAction func serivceRequestSubmit(_ sender: Any) {
        
        if(serviceName.text! == "" || userPhoneNumber.text! == "" || userAddress.text! == ""){
            showAlertEmptyField()
        }else{
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
            let uid = Auth.auth().currentUser?.uid
            let service = Service(type: type, name: serviceName.text!, description: serviceDescription.text!, serviceId: RandomGenerator.randomServiceID(), userId: uid!, status: "unclaimed", userPhone: userPhoneNumber.text!, userAddress: userAddress.text!)
            
            var ref1: DatabaseReference!
            ref1 = Database.database().reference().child("unclaimed services").child(service.serviceId)
            
            let service1 = ["type": service.type, "name": service.name, "description": service.description,"userId": service.userId,"userPhone":service.userPhone,"userAddress": service.userAddress, "status": service.status, "serviceId": service.serviceId] as [String : Any]
            ref1.setValue(service1)
//            ref.setValue(service1, withCompletionBlock: { (error: Error?, ref: DatabaseReference) in
//                print("Error")
//                })
            
           var ref2: DatabaseReference!
           ref2 = Database.database().reference().child("users").child(uid!).child("listOfUnclaimedServices").child("\(DataCurrentUser.user.listOfUnclaimedServices.count)")
            ref2.setValue(service.serviceId)
            DataCurrentUser.user.listOfUnclaimedServices.append(service.serviceId)
            //DataCurrentUser.loadServices()
            DataCurrentUser.unclaimedServices.append(service)
            showAlertSubmitted()
            activityIndicatorView.stopAnimating()
            
        }
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type = sub[row]
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
    
    func showAlertEmptyField(){
        let title = "Empty Field"
        let message = "Sorry, You have entered an empty field please fill in all the required fields"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default , handler: nil)
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertSubmitted(){
        let title = "Submitted"
        let message = "Your request has been submitted"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "backToHomeAfterSubmitingARequest", sender: nil)
        })
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true

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
