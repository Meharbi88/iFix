//
//  SignUpViewController.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/3/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    

    @IBOutlet weak var userTypeSegement: UISegmentedControl!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var iCanDoLabel: UILabel!
    @IBOutlet weak var serviceTypesPicker: UIPickerView!
    var type : String = "Plumping"
    let sub = ["Plumping", "Moving", "Appliance Repair", "Installation", "Cleaning"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sub.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sub[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        type = sub[row]
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        if (firstNameTextField.text == "" || lastNameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == ""){
            showAlert()
        }else{
            if(userTypeSegement.selectedSegmentIndex == 0){
                
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                    if let e = error {
                        self.showAlertWrongInfo(message: e.localizedDescription)
                    }
                    if let u = user {
                        let reqularUser: User = User(email: self.emailTextField.text! ,firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, password: self.passwordTextField.text!, type: "User", userId: u.uid)
                        
                        self.saveInDatabase(user: reqularUser)
                        self.performSegue(withIdentifier: "GoSignIn", sender: nil)
                    }
                }
            }else{

                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                    if let e = error {
                        self.showAlertWrongInfo(message: e.localizedDescription)

                    }
                    if let u = user {
                        let serviceProviderUser: User = User(email: self.emailTextField.text! ,firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, password: self.passwordTextField.text!, type: self.type, userId: u.uid)
                        self.saveInDatabase(user: serviceProviderUser)
                        self.performSegue(withIdentifier: "GoSignIn", sender: nil)
                    }
                }
            }
            
            
        }
    }
        
    
    
    func showAlert(){
        
        let title = "Empty Field"
        let message = "Sorry, You have entered an empty field please fill in all the required fields"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default , handler: nil)
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWrongInfo(message: String){
        
        let title = "Empty Field"
        let message = message
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default , handler: nil)
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
    func saveInDatabase(user: User){
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let user1 = ["email": user.email, "firstName": user.firstName, "lastName": user.lastName,"password": user.password,"type":user.type,"userId": user.userId]
        
        ref.root.child("users").child(user.userId).setValue(user1)


    }
    
    @IBAction func userTypeSegmentChanged(_ sender: UISegmentedControl) {
        
        if(sender.selectedSegmentIndex == 1){
            iCanDoLabel.isHidden = false
            serviceTypesPicker.isHidden = false
        }else {
            iCanDoLabel.isHidden = true
            serviceTypesPicker.isHidden = true
        }
        
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
