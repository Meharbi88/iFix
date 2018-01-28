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
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    var type : String = "Plumping"
    
    let sub = ["Plumping", "Cars", "Home Appliances", "Electricity", "Electronic Devices", "Smart Phones"]
    
    @IBAction func serivceRequestSubmit(_ sender: Any) {
        
        if(serviceName.text! == "" || userPhoneNumber.text! == "" || userAddress.text! == ""){
            showAlertEmptyField()
        }else{
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
            let uid = Auth.auth().currentUser?.uid
            let service = Service(type: type, name: serviceName.text!, description: serviceDescription.text!, serviceId: RandomGenerator.randomServiceID(), userId: uid!, serviceProviderId: "", status: "unclaimed", userPhone: userPhoneNumber.text!, userAddress: userAddress.text!, offerId: "")
        
            WriteData.writeUnclaimedService(service: service)

            //DataCurrentUser.unclaimedServices.append(service)
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
    
    @IBAction func unwindFromMap(segue:UIStoryboardSegue) {
        if let sourceViewController = segue.source as? MapViewController {
            userAddress.text = sourceViewController.address
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.isHidden = true
        submitButton.layer.cornerRadius = 15
        cancelButton.layer.cornerRadius = 15
        serviceDescription.layer.cornerRadius = 15
        
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
