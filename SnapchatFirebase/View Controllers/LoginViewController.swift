//
//  LoginViewController.swift
//  SnapchatFirebase
//
//  Created by mbtec22 on 6/23/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userOrEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyle()

        // Do any additional setup after loading the view.
    }
    
    
    func setUpStyle() {
        loginButton.layer.cornerRadius = 6.0
        userOrEmailTextField.text = "nyagua@gmail.com"
        passwordTextField.text = "nyagua123"
    }
    
    @IBAction func onClickBackbtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickLogin(_ sender: Any) {
        let user = userOrEmailTextField.text!
        let password = passwordTextField.text!
    
        Auth.auth().signIn(withEmail: user, password: password) { (responseUser, error) in
            if error == nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                let alert = UIAlertController(title: "Ups!", message: "User or Password incorrect", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
