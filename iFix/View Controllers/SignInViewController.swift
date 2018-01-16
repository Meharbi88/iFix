//
//  SignInViewController.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/3/18.
//  Copyright © 2018 Mohammad Alharbi. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    var type: String = ""
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "meharbi88@gmail.com"
        passwordTextField.text = "1804947"
        logInButton.isEnabled = true;
        DataCurrentUser.userId = ""
        DataCurrentServiceProvider.serviceProviderId = ""
        // Do any additional setup after loading the view.
    }

    @IBAction func logIn(_ sender: Any) {
        
        if(emailTextField.text == "" || passwordTextField.text == ""){
            showAlertEmptyField()
        }else{
            logInButton.isEnabled = false;
            activityIndicatorView.startAnimating()
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                
                if let e = error {
                    self.showAlertWrongInfo(description: e.localizedDescription)
                    
                }
                
                if let u1 = user {
                    let id = u1.uid
                    var ref: DatabaseReference!
                    ref = Database.database().reference()
                    ref.child("users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Get user value
                        let value = snapshot.value as? NSDictionary
                        if (value != nil){
                            self.type = value?.value(forKey: "type") as! String
                            if(self.type == "User"){
                                DataCurrentUser.userType = "User"
                                DataCurrentUser.userId = (Auth.auth().currentUser?.uid)!
                                DataCurrentUser.loadCurrentUserData()
                                DataCurrentUser.loadUnclaimedServicesData()
                                //DataCurrentUser.loadServices1()
                                DataCurrentUser.loadInProgressServicesData()
                                DataCurrentUser.loadCompleteServicesData()
                                //self.showAlertSuccess()
                                self.activityIndicatorView.stopAnimating()
                                self.performSegue(withIdentifier: "GoHomeUser", sender: self.type)
                            }
                        }else{
                            DataCurrentServiceProvider.serviceProviderId = (Auth.auth().currentUser?.uid)!
                            DataCurrentServiceProvider.loadCurrentServiceProviderData()
                            DataCurrentServiceProvider.loadUnclaimedServicesData()
                            self.activityIndicatorView.stopAnimating()
                            self.performSegue(withIdentifier: "GoHomeUser",sender: nil)
                            //self.performSegue(withIdentifier: "GoHomeServiceProvider", sender: nil)
                        }
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                    
                }
                
            })
        }
        
        
    }
    
    func checkType(userId: String){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.userType = value?.value(forKey: "type") as! String
        }) { (error) in
            print(error.localizedDescription)
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
    
    func showAlertSuccess(){
        let title = "Success"
        let message = "Success"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default , handler: {
            (alert: UIAlertAction!) -> Void in
            self.activityIndicatorView.stopAnimating()
            self.performSegue(withIdentifier: "GoHomeUser", sender: nil)
            
        })
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWrongInfo(description: String){
        
        let title = "Wrong Information"
        let message = description
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.activityIndicatorView.stopAnimating()
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.logInButton.isEnabled = true
        })
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
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