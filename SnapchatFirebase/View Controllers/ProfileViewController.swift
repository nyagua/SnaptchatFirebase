//
//  ProfileViewController.swift
//  SnapchatFirebase
//
//  Created by mbtec22 on 6/24/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import Firebase
import ASProgressHud

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    // Outlets
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var emailLabelData: UILabel!
    @IBOutlet weak var uidLabelData: UILabel!
    
    // Button
    @IBOutlet weak var logOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dowloadProfiel()
        printUserAuth()
        setUpStyle()
        self.imagePicker.delegate = self
        
    }
    
    // Funciont print data user
    func printUserAuth() {
        let userAuth = Firebase.Auth.auth().currentUser;
        if (userAuth !== nil) {
            let emailData = userAuth?.email;
            let uidData = userAuth?.uid;
            
            // Print data label
            self.emailLabelData.text = emailData;
            self.uidLabelData.text = uidData;
        }
    }
    
    func dowloadProfiel(){
        if let user = Auth.auth().currentUser{
            let store = Storage.storage()
            let storeRef = store.reference().child("images/\(user.uid)/profile_photo.jpg")
                   
            storeRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                } else {
                    let image = UIImage(data: data!)
                    self.imageProfile.image = image
                }
            }
        }else{
            print("You should be logged in")
        }
    }
    
    
    //Function to add border for button LogOut
    func setUpStyle() {
        logOutButton.layer.cornerRadius = 6.0
    }
    

    
    // Function to LogOut Authentication
    @IBAction func signOutButtonAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let (err){
            print(err)
        }
        
    }
    
    // Open library to select a photo
    @IBAction func changeProfileImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
        
        if let user = Auth.auth().currentUser{
            let store = Storage.storage()
            let storeRef = store.reference().child("images/\(user.uid)/profile_photo.jpg")
                   
            storeRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print("error: \(error.localizedDescription)")
                } else {
                    let image = UIImage(data: data!)
                    self.imageProfile.image = image
                }
            }
        }else{
            print("You should be logged in")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        let imagePostPicker = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
        
        let imageData: Data = imagePostPicker.jpegData(compressionQuality: 0.5)!
        let store = Storage.storage()
        let user = Auth.auth().currentUser
        if let user = user{
            let storeRef = store.reference().child("images/\(user.uid)/profile_photo.jpg")
                ASProgressHud.showHUDAddedTo(self.view, animated: true, type: .default)
                    let _ = storeRef.putData(imageData, metadata: metadata) { (metadata, error) in
                    ASProgressHud.hideHUDForView(self.view, animated: true)
                        guard let _ = metadata else {
                    print("error occurred: \(error.debugDescription)")
                    return
                }
         
                self.imageProfile.image = imagePostPicker
            }
                     
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
