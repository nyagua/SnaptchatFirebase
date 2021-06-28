//
//  SingUpViewController.swift
//  SnapchatFirebase
//
//  Created by mbtec22 on 6/24/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import FirebaseAuth

class SingUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }

    @IBAction func onClickBackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setupStyle() {
        signUpButton.layer.cornerRadius = 6.0
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let email = emailTextfield.text!
        let password = passwordTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if error == nil {
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
            } else {
                let alert = UIAlertController(title: "Ups!", message: "User could not be created", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }

    
}
