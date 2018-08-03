//
//  RegisterViewController.swift
//  TravelBoard
//
//  Created by Vineet Baid on 5/15/18.
//  Copyright © 2018 Vineet Baid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import SVProgressHUD

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Variables & Constants
    
    //for image pickers:
    let picker = UIImagePickerController()
    //for the storage for Firebase:
    var userStorage : StorageReference!
    var databaseReference : DatabaseReference!
    let storageURL = "gs://travelboard-79fa1.appspot.com"
    let userStorageString = "users"
    
    //MARK: IBOutlets
    
    @IBOutlet var fullName: UITextField!
    @IBOutlet var nationalityField: UITextField!
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passwordOne: UITextField!
    @IBOutlet var passwordTwo: UITextField!
    @IBOutlet var imagePicked: UIImageView!
    @IBOutlet var currentCity: UITextField!
    
    
    //MARK: View:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //back button to get to Login since I decided not to embed in navigation controller:
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        
        picker.delegate = self
        //This is to get an object and instantiate the storage reference for a new user:
        let storageObject = Storage.storage().reference(forURL: storageURL)
        userStorage = storageObject.child(userStorageString)
        //userStorageString is just users in string form. But wanted to make it a constant
        //Database Reference:
        databaseReference = Database.database().reference()
    }

    //MARK: IBActions:
    @IBAction func registerPressed(_ sender: Any) {
        loadingStart()

        //first check to make sure no empty strings
        guard fullName.text != "", nationalityField.text != "", emailInput.text != "", passwordOne.text != "", passwordTwo.text != "", currentCity.text != "", imagePicked.image != nil else {
            //if there is some empty string then let the user know
            alertFunc(message: "Some Information Is Missing", title: "Please Fill This All Out Including a Picture", buttonTitle: "Try Again")
            self.loadingFinished()
            return
        }
        
        
        if passwordOne.text! == passwordTwo.text! {
            //Authorize a new user here as long as both passwords match
            Auth.auth().createUser(withEmail: emailInput.text!, password: passwordOne.text!, completion: { (user, error) in
                if error != nil {
                    self.alertFunc(message: error!.localizedDescription, title: "Please Try Again", buttonTitle: "Try Again")
                    self.loadingFinished()

                }
                else {
                    //So no error in authorizing a user so now we need to upload the picture. This creates a new child  of that picture and we call it the UID.jpg:
                    let imageUploadReference = self.userStorage.child("\(user!.user.uid).jpeg")
                    //Turn the image into data:
                    let imageDataToUpload = UIImageJPEGRepresentation(self.imagePicked.image!, 0.5)
                    //Now upload that using the imageUploadReference
                    imageUploadReference.putData(imageDataToUpload!, metadata: nil, completion: { (metaData, error) in
                        if error != nil {
                            self.alertFunc(message: error!.localizedDescription, title: "Please Try Again", buttonTitle: "Try Again")
                            self.loadingFinished()

                        }
                        else {
                            //So now we have it up on firebase. We download the link to it so that it is easy to find and we can add it to the user's information
                            imageUploadReference.downloadURL(completion: { (url, error) in
                                if error != nil {
                                    self.alertFunc(message: error!.localizedDescription, title: "Please Try Again", buttonTitle: "Try Again")
                                    self.loadingFinished()

                                }
                                else {
                                    //This is final else nest -THERE'S SO MANY- so gonna upload to database now with the imageURL and all the different details the user posted
                                    //Please see the Profile Model file associated with this
                                    let userDataInDictForm = Profile(name: self.fullName.text!, imageString: url!.absoluteString, nationality: self.nationalityField.text!, currentCity: self.currentCity.text!, uID: user!.user.uid).turnToDictionary()
                                    self.databaseReference.child(self.userStorageString).child(user!.user.uid).setValue(userDataInDictForm)
                                    self.loadingFinished()
                                    //Now that it is posted we can performSegue:
                                    self.performSegue(withIdentifier: "RegisteredSegue", sender: nil)
                                    
                                    
                                    
                                    
                                    
                                }
                            })
                        }
                    })
                    
                    
                }
            })
            
        }
        else {
            alertFunc(message: "Passwords Were Different", title: "Please Try Again", buttonTitle: "Try Again")
            self.loadingFinished()
        }
        
    }
    
    @IBAction func selectPicture(_ sender: Any) {
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func dismissRegisterViewController(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //MARK: - IMAGE PICKER Funcs
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageSelected = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imagePicked.image = imageSelected
            dismiss(animated: true, completion: nil)
            
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    
    
    

    //
    

}

//Created an extension in order to allow pop up functions whenever there is an error through all VC's.
extension UIViewController {
    func alertFunc(message: String, title: String, buttonTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionBack = UIAlertAction(title: buttonTitle, style: .cancel) { (action) in
        }
        alert.addAction(actionBack)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //Another extension I plan to use: One that does both SVProgressHUD Show and one that dismisses
    func loadingStart(){
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
    }
    func loadingFinished(){
        SVProgressHUD.dismiss()
        self.view.isUserInteractionEnabled = true
    }
    
}
