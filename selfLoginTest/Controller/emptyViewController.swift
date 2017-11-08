//
//  emptyViewController.swift
//  selfLoginTest
//
//  Created by Erkut Baş on 08/11/2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class emptyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOutButton(_ sender: UIButton) {
        
        try! Auth.auth().signOut()
        
        
        if let result : Bool = KeychainWrapper.standard.removeObject(forKey: KEY_UID) {
            
            print("ahanda sildik seni")
            
            performSegue(withIdentifier: "goToSignIn", sender: self)
        }
        
    }
    

}
