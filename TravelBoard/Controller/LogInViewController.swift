//
//  ViewController.swift
//  TravelBoard
//
//  Created by Vineet Baid on 5/12/18.
//  Copyright © 2018 Vineet Baid. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import FirebaseStorage

class LogInViewController: UIViewController {

    //IBOutlets Below for Email and Password Text
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) {
        
        //OVER HERE Make all the Static Var's equal to nil
        
    }

    
    //MARK: Login
    @IBAction func loginPressed(_ sender: Any) {
        self.loadingStart()
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                self.alertFunc(message: error!.localizedDescription, title: "Please Try Again", buttonTitle: "Try Again")
                self.loadingFinished()
            }
            else {
                //TODO: Have to load up stuff. This is where the table view will get it's stuff
                self.performSegue(withIdentifier: "LogInComplete", sender: nil)
                self.loadingFinished()
            }
        }
        
    }
    


}



