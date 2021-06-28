//
//  PostsViewController.swift
//  SnapchatFirebase
//
//  Created by mbtec22 on 6/25/21.
//  Copyright © 2021 Tecsup. All rights reserved.
//

import UIKit
import Firebase

class PostsViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setuo atter loading the view
    }
    
    
    @IBAction func toPostButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "postSegue", sender: nil)
        
    }

    
}
