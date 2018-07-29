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

//Created an extension in order to allow pop up functions whenever there is an error. An extension so that this can be used in every view controller
extension UIViewController {
    func alertFunc(message: String, title: String, buttonTitle: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionBack = UIAlertAction(title: buttonTitle, style: .cancel) { (action) in
        }
        alert.addAction(actionBack)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //Another extension I plan to use: One that does both SVProgressHUD Show and one that
    func loadingStart(){
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
    }
    func loadingFinished(){
        SVProgressHUD.dismiss()
        self.view.isUserInteractionEnabled = true
    }
    
}

