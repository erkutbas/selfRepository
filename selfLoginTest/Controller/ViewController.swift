//
//  ViewController.swift
//  selfLoginTest
//
//  Created by Erkut Baş on 07/11/2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SwiftKeychainWrapper

class ViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var buttonSignIn: buttonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        print("viewDidAppear is activated")
        
        /*
        emailText.setValue(UIColor.init(red: 80/255, green: 80/255, blue: 80/255, alpha: 1.0), forKeyPath: "_placeholderLabel.textColor")
        
        passwordText.setValue(UIColor.init(red: 80/255, green: 80/255, blue: 80/255, alpha: 1.0), forKeyPath: "_placeholderLabel.textColor")
        */
        
        getScreenBlur()
        
        emailField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        passwordField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")

        
        emailField.setBottomBorder()
        passwordField.setBottomBorder()
        
        buttonSignIn.backgroundColor = UIColor(white: 1, alpha: 0.0)
        
        buttonSignIn.setBorders()
        
        if let _ = KeychainWrapper.defaultKeychainWrapper.string(forKey: KEY_UID){
            print("Erkut: ID found in keychain")
            performSegue(withIdentifier: "GoToEmpty", sender: nil)
        }
        
        
    }
    
    func getScreenBlur() {
        
        //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = mainImageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainImageView.addSubview(blurEffectView)
        
    }

    @IBAction func singInButton(_ sender: UIButton) {
        
        print("Erkut : singInButton is tapped")
        
        if let email = emailField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Erkut: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Erkut: Unable to authenticate with Firebase using email")
                            
                            if let errorMessage = error as NSError? {
                                
                                print("Erkut : errorMessage : \(errorMessage.userInfo)")
                                print("Erkut : errorMessage : \(errorMessage)")

                                
                            }
                            
                        } else {
                            print("Erkut: Successfully authenticated with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        //DataService.ds.createFirbaseDBUser(uid: id, userData: userData)
        //let keychainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        let keychainResult = KeychainWrapper.defaultKeychainWrapper.set(id, forKey: KEY_UID)
        print("Erkut: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "GoToEmpty", sender: nil)
    }
}

extension UITextField
{
    func setBottomBorder()
    {
        self.borderStyle = UITextBorderStyle.none;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIButton {
    
    func setBorders()
    {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
    
}
