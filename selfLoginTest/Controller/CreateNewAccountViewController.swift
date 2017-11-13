//
//  CreateNewAccountViewController.swift
//  selfLoginTest
//
//  Created by Erkut Baş on 13/11/2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import TwitterKit

class CreateNewAccountViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var createAccountButton: buttonView!
    @IBOutlet var createAccountImage: UIImageView!
    @IBOutlet var twitterLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getScreenBlur()
        setPlaceHolderTextForegroundColour()
        enableRootNavigationBar()
        setButtonBackgroundColor()
        setTextFieldBottomBorders()
        loginWithTwitter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func disableRootNavigationBar() {
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func enableRootNavigationBar() {
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func setButtonBorders() {
        
        self.createAccountButton.setBorders()
        
    }
    
    private func setButtonBackgroundColor() {
        
        self.createAccountButton.setBackgroundColorAlpha1()
    }
    
    private func setTextFieldBottomBorders() {
        
        self.emailField.setBottomBorder()
        self.passwordField.setBottomBorder()
        
    }
    
    private func setPlaceHolderTextForegroundColour() {
        
        emailField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        passwordField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        
    }
    
    private func getScreenBlur() {
        
        //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = createAccountImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        createAccountImage.addSubview(blurEffectView)
        
    }
    
    private func loginWithTwitter() {
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            
            if (session != nil) {
                print("signed in as \(session?.userName)");
                
                if let sessionObject = session as TWTRSession? {
                    
                    let authToken = sessionObject.authToken
                    let authTokenSecret = sessionObject.authTokenSecret
                    
                    let credential = TwitterAuthProvider.credential(withToken: authToken, secret: authTokenSecret)
                    
                    Auth.auth().signIn(with: credential, completion: { (user, error) in
                        
                        if error != nil {
                            
                            if let errorMessage = error as NSError? {
                                
                                print("errorrrrrr twitter 1 : \(errorMessage)")
                                print("errorrrrrr twitter 2 : \(errorMessage.localizedDescription)")
                                print("errorrrrrr twitter 3 : \(errorMessage.userInfo)")
                                
                            }
                            
                        } else {
                            
                            print("şak şak spor")
                        }
                        
                    })
                    
                }
                
            } else {
                print("error: \(error?.localizedDescription)");
            }
        })
        
        //logInButton.center = self.view.center
        //self.view.addSubview(logInButton)
        
        logInButton.frame = CGRect(x: 1, y: 1, width: 343, height: 43)
        self.twitterLoginButton.addSubview(logInButton)
        
    }
    

    /*
     action functions
     */
    @IBAction func createAccountButtonTapped(_ sender: Any) {
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("facebook login process starts")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    
        print("facebook log out process starts")
    }
    
    

}
