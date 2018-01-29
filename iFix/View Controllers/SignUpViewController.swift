//
//  SignUpViewController.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/3/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var userTypeSegement: UISegmentedControl!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var iCanDoLabel: UILabel!
    @IBOutlet weak var serviceTypesPicker: UIPickerView!
    var type : String = "Plumbing"
    let sub = ["Plumbing", "Cars", "Home Appliances", "Electricity", "Electronic Devices", "Smart Phones"]
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstNameTextField.endEditing(true)
        lastNameTextField.endEditing(true)
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.endEditing(true)
        lastNameTextField.endEditing(true)
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        cancelButton.layer.cornerRadius = 15
        cancelButton.layer.borderColor = UIColor.black.cgColor
        cancelButton.layer.borderWidth = 2
        
        signUpButton.layer.cornerRadius = 15
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.borderWidth = 2
        userTypeSegement.layer.cornerRadius = 15
        firstNameTextField.layer.cornerRadius = 15
        lastNameTextField.layer.cornerRadius = 15
        emailTextField.layer.cornerRadius = 15
        passwordTextField.layer.cornerRadius = 15
        serviceTypesPicker.layer.cornerRadius = 15
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
            showAlertEmptyField()
        }else{
            if(userTypeSegement.selectedSegmentIndex == 0){
                
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                    if let e = error {
                        self.showAlertWrongInfo(message: e.localizedDescription)
                    }
                    if let u = user {
                        let reqularUser: User = User(email: self.emailTextField.text! ,firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, password: self.passwordTextField.text!, type: "User", userId: u.uid)
                        WriteData.writeUser(user: reqularUser)
                        self.performSegue(withIdentifier: "GoSignIn", sender: nil)
                    }
                }
            }else{

                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                    if let e = error {
                        self.showAlertWrongInfo(message: e.localizedDescription)

                    }
                    if let u = user {
                        let serviceProviderUser: ServiceProvider = ServiceProvider(email: self.emailTextField.text! ,firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, password: self.passwordTextField.text!, type: self.type, serviceProviderId: u.uid)
                        WriteData.writeServiceProvider(serviceProvider: serviceProviderUser)
                        self.performSegue(withIdentifier: "GoSignIn", sender: nil)
                    }
                }
            }
            
            
        }
    }
    
    func showAlertEmptyField(){
        
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
