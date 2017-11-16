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
    
    @objc func checkUserVerificationAndPerformAnotherPage() {
        
        print("bokbokbok")
        
        Auth.auth().currentUser?.reload(completion: { (error) in
            if error != nil {
                
                if let errorMessage = error as NSError? {
                    
                    print("errorMessage : \(errorMessage.localizedDescription)")
                    
                }
                
            } else {
                
                if Auth.auth().currentUser?.isEmailVerified == true {
                    
                    print("user is verified")
                    self.createAlertAfterEmailVerificationSuccessfull()
                } else {
                    
                    print("user is not verified")
                    
                }
                
            }
        })
        
    }
    
    func createAlertAfterEmailVerificationSuccessfull() {
        
        let alert = UIAlertController(title: "E-Mail Verification Result", message: "Everthing is ok", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let action = #selector(checkUserVerificationAndPerformAnotherPage)
        
        NotificationCenter.default.addObserver(self, selector: action, name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        // Do any additional setup after loading the view.
        
        emailField.text = "erkutbas007@gmail.com"
        passwordField.text = "123456"
        
        getScreenBlur()
        setPlaceHolderTextForegroundColour()
        enableRootNavigationBar()
        setButtonBackgroundColor()
        setTextFieldBottomBorders()
        loginWithTwitter()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        
        Auth.auth().currentUser?.reload(completion: { (error) in
            
            if error != nil {
                
                if let errorMes = error as NSError? {
                    
                    print(">>>>>> :\(errorMes)")
                    
                }
            } else {
                
                print("başarılı")
            }
            
            let takasi  = Auth.auth().currentUser?.isEmailVerified
            
            print("koko : \(takasi)")
            
        })
        
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
                        
                        print("user : \(user?.isEmailVerified)")
                        
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
        
        if let email = emailField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                
                print("user : \(user?.isEmailVerified)")
                
                Auth.auth().currentUser?.reload(completion: { (error) in
                    
                    if error != nil {
                        
                        if let errorMes = error as NSError? {
                            
                            print(">>>>>> :\(errorMes)")
                            
                        }
                    } else {
                        
                        print("başarılı")
                    }
                    
                    let takasi  = Auth.auth().currentUser?.isEmailVerified
                    
                    print("koko : \(takasi)")
                    
                })
                
                print("user_ : \(user?.isEmailVerified)")

                
                if error == nil {
                    print("Erkut: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        print("userData : \(userData)")
                        
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        
                        print("user : \(user?.isEmailVerified)")
                        
                        if error != nil {
                            print("Erkut: Unable to authenticate with Firebase using email")
                            
                            if let errorMessage = error as NSError? {
                                
                                print("Erkut : errorMessage : \(errorMessage.userInfo)")
                                print("Erkut : errorMessage : \(errorMessage)")
                                
                            }
                            
                        } else {
                            print("Erkut: Successfully authenticated with Firebase")
                            if let user = user {
                                let userData = ["provider": user.providerID, "takasi" : "takasiValue", "takasi_2" : "takasi_2_Value"]
                                
                                print("userData : \(userData)")
                                
                                print("*********************************")
                                var actionCodeSettings =  ActionCodeSettings.init()
                                actionCodeSettings.handleCodeInApp = true
                                //let user = Auth.auth().currentUser
                                // This URL will be the deep link of the FDL. It is useful for
                                // passing state back to your iOS app to let it know that you were
                                // verifying a user of email user.email. This is also useful
                                // in case the user clicks the continue button a non iOS device.
                                // You should own this link.
                                
                                actionCodeSettings.url = URL(string: String(format: "myLoginPageApp://self-login-test.firebaseapp.com?email=%@", self.emailField.text!))
                                
                                print("actionCodeSetting : \(actionCodeSettings.url)")
                                
                                // This is your iOS app bundle ID. It will try to redirect to your
                                // app via Firebase dynamic link.
                                actionCodeSettings.setIOSBundleID("com.erkutbas.selfLoginTest")
                                
                                user.sendEmailVerification(with: actionCodeSettings, completion: { (error) in
                                    
                                    print("email verification basliyorrrrrrrrrrrrrrr")
                                    
                                    if error != nil {
                                        
                                        print("hata geldi")
                                        
                                        if let errorMessage = error as NSError? {
                                            
                                            print("errorMessage : \(errorMessage)")
                                            print("errorMessage : \(errorMessage.userInfo)")
                                            print("errorMessage : \(errorMessage.localizedDescription)")
                                            
                                        }
                                        
                                        
                                    } else {
                                        
                                        print("email verification sent")
                                        
                                    }
                                })
                            }
                        }
                    })
                }
            })
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("facebook login process starts")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    
        print("facebook log out process starts")
    }
    
    

}
