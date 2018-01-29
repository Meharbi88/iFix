//
//  ProfileViewController.swift
//  iFix
//
//  Created by Mohammad Alharbi on 1/22/18.
//  Copyright © 2018 Mohammad Alharbi, Fahad Alharbi. All rights reserved.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var serviceNo: UILabel!
    @IBOutlet weak var offersNo: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    var imageHasChange : Bool = false
    var once : Bool = true
    
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
    
    @IBAction func didClickEditButton(_ sender: Any) {
        updateFlags(buttonName: "edit")
    }
    
    @IBAction func saveEditing(_ sender: Any) {
        if (firstNameTextField.text == "" || lastNameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == ""){
            showAlertEmptyField()
        } else{
            let uid = Auth.auth().currentUser?.uid
            if DataCurrentUser.userType == "User"{
                let newUser : User = User(email: self.emailTextField.text!, firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, password: self.passwordTextField.text!, type: "User", userId: uid!)
                WriteData.writeUser(user: newUser)
                uploadImage()
                updateAuth()

            }else{
                let newServiceProvider : ServiceProvider = ServiceProvider(email: self.emailTextField.text!, firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, password: self.passwordTextField.text!, type: DataCurrentServiceProvider.serviceProviderType, serviceProviderId: uid!)
                WriteData.writeServiceProvider(serviceProvider: newServiceProvider)
                uploadImage()
                updateAuth()
                
            }
            updateFlags(buttonName: "save")

        }
    }
    
    func updateAuth(){
        Auth.auth().currentUser?.updateEmail(to: self.emailTextField.text!, completion: { (error) in
            print("email couldn't update")
        })
        Auth.auth().currentUser?.updatePassword(to: self.passwordTextField.text!, completion: { (error) in
            print("password couldn't update")
        })
    }

    
    @IBAction func didClickImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                self.showAlertCameraDoesntWork()
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.image = image
        imageHasChange = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlertCameraDoesntWork(){
        let title = "Camera Not Available"
        let message = "Sorry, Camera is not available"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default , handler: nil)
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertEmptyField(){
        
        let title = "Empty Field"
        let message = "Sorry, You have entered an empty field please fill in all the required fields"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default , handler: nil)
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
    
    func uploadImage(){
        if(imageHasChange){
            let imageName = Auth.auth().currentUser?.uid ?? "0"
            UploadData.uploadUserOrServiceProviderProfileImage(imageName: imageName, image: profileImage.image)
        }
    }
    
    func loadData(){
        if (DataCurrentUser.userType == "User"){
            firstNameTextField.text = DataCurrentUser.user.firstName
            lastNameTextField.text = DataCurrentUser.user.lastName
            emailTextField.text = DataCurrentUser.user.email
            profileImage.image = DataCurrentUser.image
            serviceNo.text =
            "Services:\nUnclaimed: \(DataCurrentUser.unclaimedServices.count).\nIn progress: \(DataCurrentUser.inProgressServices.count).\nCompleted: \(DataCurrentUser.completeServices.count)."
            
            offersNo.text = "Offers:\nUndetermined: \(DataCurrentUser.undeterminedOffers.count).\nAccepted: \(DataCurrentUser.acceptedOffers.count).\nDeclined: \(DataCurrentUser.declinedOffers.count)."
            
            
        }else{
            firstNameTextField.text = DataCurrentServiceProvider.serviceProvider.firstName
            lastNameTextField.text = DataCurrentServiceProvider.serviceProvider.lastName
            emailTextField.text = DataCurrentServiceProvider.serviceProvider.email
            profileImage.image = DataCurrentServiceProvider.image
            
            serviceNo.text =
            "Services:\nUnclaimed: \(DataCurrentServiceProvider.unclaimedServices.count).\nIn progress: \(DataCurrentServiceProvider.inProgressServices.count).\nCompleted: \(DataCurrentServiceProvider.completeServices.count)."
            
            offersNo.text = "Offers:\nUndetermined: \(DataCurrentServiceProvider.undeterminedOffers.count).\nAccepted: \(DataCurrentServiceProvider.acceptedOffers.count).\nDeclined: \(DataCurrentServiceProvider.declinedOffers.count)."
            
        }
        
    }
    
    func updateFlags(buttonName: String){
        if(buttonName == "edit"){
            editButton.isEnabled = false
            tapGesture.isEnabled = true
            firstNameTextField.isEnabled = true
            lastNameTextField.isEnabled = true
            emailTextField.isEnabled = true
            passwordTextField.isHidden = false
            passwordTextField.isEnabled = true
            saveButton.isEnabled = true
            saveButton.isHidden = false
            logoutButton.isEnabled = false
            logoutButton.isHidden = true
        }else if(buttonName == "save"){
            editButton.isEnabled = true
            tapGesture.isEnabled = false
            firstNameTextField.isEnabled = false
            lastNameTextField.isEnabled = false
            emailTextField.isEnabled = false
            passwordTextField.isHidden = true
            passwordTextField.isEnabled = false
            saveButton.isEnabled = false
            saveButton.isHidden = true
            logoutButton.isEnabled = true
            logoutButton.isHidden = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        //profileImage.layer.cornerRadius = 70
        passwordTextField.text = "1804947"
        
        logoutButton.layer.cornerRadius = 15
        logoutButton.layer.borderColor = UIColor.black.cgColor
        logoutButton.layer.borderWidth = 2
        
        saveButton.layer.cornerRadius = 15
        saveButton.layer.borderColor = UIColor.black.cgColor
        saveButton.layer.borderWidth = 2

        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true;
        profileImage.layer.borderWidth = 10.0
        profileImage.layer.borderColor = UIColor.white.cgColor
        
        loadData()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if(once){
            loadData()
            once = false;
        }
    }

    @IBAction func logout(_ sender: Any) {
        DataCurrentUser.clear()
        DataCurrentServiceProvider.clear()
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
