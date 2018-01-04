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

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logIn(_ sender: Any) {
        if(emailTextField.text == "" || passwordTextField.text == ""){
            showAlert()
        }else{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                
                if let e = error {
                    self.showAlertWrongInfo(description: e.localizedDescription)
                }
                
                if let u = user {
                    let id = u.uid
                    var ref: DatabaseReference!
                    ref = Database.database().reference()
                    ref.child("users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                        // Get user value
                        let value = snapshot.value as? NSDictionary
                        let type = value?.value(forKey: "type") as! String
                        print(type)
                        if(type == "User"){
                            self.performSegue(withIdentifier: "GoHomeUser", sender: nil)
                        }else{
                            self.performSegue(withIdentifier: "GoHomeServiceProvider", sender: nil)
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
    
    func showAlert(){
        
        let title = "Empty Field"
        let message = "Sorry, You have entered an empty field please fill in all the required fields"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default , handler: nil)
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWrongInfo(description: String){
        
        let title = "Wrong Information"
        let message = description
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default , handler: nil)
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