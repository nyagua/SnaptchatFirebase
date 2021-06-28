//
//  contactHomeViewController.swift
//  SnapchatFirebase
//
//  Created by mbtec22 on 6/25/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class contactHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var contactTableView: UITableView!
    
    var imageURL = ""
    var descrip = ""
    var imagenID = ""
    
    var users : [User] = []
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.delegate = self
        contactTableView.dataSource = self
        self.ref = Database.database().reference()
        self.ref.child("users").observe(DataEventType.childAdded, with: {(DataSnapshot) in
            let user = User()
            user.email = (DataSnapshot.value as! NSDictionary)["email"] as! String
            user.uid = DataSnapshot.key
            self.users.append(user)
            self.contactTableView.reloadData()
            print(DataSnapshot)
        })
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let snap = ["from":Auth.auth().currentUser!.email!, "description":descrip, "imageURL":imageURL, "imagenID":imagenID]
            self.ref = Database.database().reference()
            self.ref.child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController?.popToRootViewController(animated: true)
    }

}
