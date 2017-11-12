//
//  ProfileViewController.swift
//  selfLoginTest
//
//  Created by Erkut Baş on 11/11/2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profileView: UIImageView!
    @IBOutlet var nickNameFiedl: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var surNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false

        
        getScreenBlur()
        
        // Do any additional setup after loading the view.
        
        nickNameFiedl.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        nameField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        surNameField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        
        
        nickNameFiedl.setBottomBorder()
        nickNameFiedl.setBottomBorder()
        
        nameField.setBottomBorder()
        nameField.setBottomBorder()
        
        surNameField.setBottomBorder()
        surNameField.setBottomBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        
        getScreenBlur()
        
        
        nickNameFiedl.setBottomBorder()
        nickNameFiedl.setBottomBorder()
        
        nameField.setBottomBorder()
        nameField.setBottomBorder()
        
        surNameField.setBottomBorder()
        surNameField.setBottomBorder()
        
    }*/
    
    func getScreenBlur() {
        
        //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = profileView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        profileView.addSubview(blurEffectView)
        
    }
    

}


