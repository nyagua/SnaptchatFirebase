//
//  UploadImageViewController.swift
//  SnapchatFirebase
//
//  Created by mbtec22 on 6/25/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import Firebase

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    // Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectImageButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func postImageButton(_ sender: Any) {
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imageView?.image = img
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
