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

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Variables
    //for image pickers:
    let picker = UIImagePickerController()
    //Tfor the storage for Firebase:
    var userStorage : StorageReference!
    //the storageURL for the app that we will use
    let storageURL = "gs://travelboard-79fa1.appspot.com"
    //So that
    
    
//IBOutlets
    @IBOutlet var fullName: UITextField!
    @IBOutlet var nationalityField: UITextField!
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passwordOne: UITextField!
    @IBOutlet var passwordTwo: UITextField!
    @IBOutlet var imagePicked: UIImageView!
    @IBOutlet var currentCity: UITextField!
    
    
    //Functions and onwards:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Change the backbutton item:
        self.navigationItem.backBarButtonItem?.title = "Welcome"
        //to be a delegate for the picture picker:
        picker.delegate = self
        //This is to get an object and instantiate the storage reference for a new user
        let storageObject = Storage.storage().reference(forURL: storageURL)
        userStorage = storageObject.child("users")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //IBOActions:
    @IBAction func registerPressed(_ sender: Any) {
        //first check to make sure no empty strings
        guard fullName.text != "", nationalityField.text != "", emailInput.text != "", passwordOne.text != "", passwordTwo.text != "", currentCity.text != "" else {
            //if there is some empty string then let the user know
            alertFunc(message: "Some Information Is Missing", title: "Please Fill This All Out", buttonTitle: "Try Again")
            return
        }
        
        
        if passwordOne.text! == passwordTwo.text! {
            //Authorize here
            Auth.auth().createUser(withEmail: emailInput.text!, password: passwordOne.text!, completion: { (user, error) in
                if error != nil {
                    
                }
                else {
                    
                }
            })
            
        }
        else {
            alertFunc(message: "Passwords Were Different", title: "Please Try Again", buttonTitle: "Try Again")
            //alertFunc is from the extension
        }
        
    }
    
    @IBAction func selectPicture(_ sender: Any) {
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
        
    }
    
    //MARK: - Next two functions are to be able to pick an image
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
