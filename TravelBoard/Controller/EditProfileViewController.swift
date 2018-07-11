//
//  EditProfileViewController.swift
//  TravelBoard
//
//  Created by Vineet Baid on 7/11/18.
//  Copyright © 2018 Vineet Baid. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Variables & Constants
    //for image pickers:
    let picker = UIImagePickerController()
    //for the storage for Firebase:
    var userStorage : StorageReference!
    var databaseReference : DatabaseReference!
    let storageURL = "gs://travelboard-79fa1.appspot.com"
    let userStorageString = "users"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self


    }


}
