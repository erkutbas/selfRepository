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

import FBSDKLoginKit
import FBSDKCoreKit

import TwitterKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet var buttonLoginWithFacebook: FBSDKLoginButton!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var buttonSignIn: buttonView!
    @IBOutlet var customButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.isNavigationBarHidden = false
        
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
        
        //getScreenBlur()
                
        emailField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        passwordField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")

        
        emailField.setBottomBorder()
        passwordField.setBottomBorder()
        
        buttonSignIn.backgroundColor = UIColor(white: 1, alpha: 0.0)
        buttonSignIn.setBorders()
        
        self.buttonLoginWithFacebook.delegate = self
        
        takasi()
        //takasi_2()
        
        if let _ = KeychainWrapper.defaultKeychainWrapper.string(forKey: KEY_UID){
            print("Erkut: ID found in keychain")
            //performSegue(withIdentifier: "goToProfileView", sender: nil)
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
        
        let userDataRetrived = UserStructure()
        
        userDataRetrived.setEmailAddress(email: emailField.text!)
        
        if let email = emailField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Erkut: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        print("userData : \(userData)")

                        userDataRetrived.setUserID(userID: user.uid)
                        
                        //self.completeSignIn(id: user.uid, userData: userData)
                        self.completeSignInWithFaceOrTwitter(id: user.uid, userData: userDataRetrived)
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
                                let userData = ["provider": user.providerID, "takasi" : "takasiValue", "takasi_2" : "takasi_2_Value"]
                                
                                print("userData : \(userData)")
                                
                                userDataRetrived.setUserID(userID: user.uid)

                                
                                //self.completeSignIn(id: user.uid, userData: userData)
                                self.completeSignInWithFaceOrTwitter(id: user.uid, userData: userDataRetrived)

                                
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirbaseDBUser(uid: id, userData: userData)
        //let keychainResult = KeychainWrapper.setString(id, forKey: KEY_UID)
        let keychainResult = KeychainWrapper.defaultKeychainWrapper.set(id, forKey: KEY_UID)
        print("Erkut: Data saved to keychain \(keychainResult)")
        //performSegue(withIdentifier: "goToProfilePage", sender: nil)
    }
    
    func completeSignInWithFaceOrTwitter(id: String, userData : UserStructure) {
        
        print("id : \(id)")
        print("userdata : \(userData.userEmail)")
        print("userdata : \(userData.userID)")
        
        var userDataDictionary = Users()
        
        userDataDictionary.addUserData(userInfo: userData)
        
        print("completeSignInWithFaceOrTwitter starts")
        
        let keychainResult = KeychainWrapper.defaultKeychainWrapper.set(id, forKey: KEY_UID)
        print("Erkut: Data saved to keychain \(keychainResult)")
        
        DataService.ds.createFirbaseDBUser(uid: id, userData: userDataDictionary.getUserDataAsDictionary())
        
        performSegue(withIdentifier: "goToProfileView", sender: self)
        
        
    }
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        print("Erkut : default facebook login button is tapped")
        
        let userDataRetrived = UserStructure()
        
        if error != nil {
            
            if let errorMessage = error as NSError? {
                
                print("Erkut : facebook login has failed, errorMessage :\(errorMessage.userInfo)")
                print("Erkut : facebook login has failed, errorMessage :\(errorMessage.localizedDescription)")
                
            }
            
        } else if result.isCancelled {
            
            print("Erkut : user is cancelled facebook login");
            
        } else {
            
            print("Erkut : user is start login process successfully")
            
            let credentials = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            print("credentials : \(credentials)")
            
            startFirebaseAuthProcess(credentialTakenFromFacebook: credentials)
            
            print("____________credential : \(credentials.provider)")
            print("____________credential : \(FBSDKAccessToken.current().tokenString)")
            userDataRetrived.setUserID(userID: FBSDKAccessToken.current().tokenString)
            
            let loggedInUserInfo = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: FBSDKAccessToken.current().tokenString, version: nil, httpMethod: "GET")
            
            loggedInUserInfo?.start(completionHandler: { (connection, result, error) in
                
                if error != nil {
                    
                    if let errorMessage = error as NSError? {
                        
                        print("Takasi bom bom : \(errorMessage.userInfo)")
                        
                    }
                    
                } else {
                    
                    print(result)
                    
                    if let resultString = result as? NSDictionary {
                        
                        if let emailText = resultString["email"] as? String {
                            
                            print("email : \(emailText)")
                            
                            userDataRetrived.setEmailAddress(email: emailText)
                            
                        }
                        
                        if let nameText = resultString["name"] as? String {
                            
                            print("name : \(nameText)")
                            
                        }
                        
                        if let IdText = resultString["id"] as? String {
                            
                            print("id : \(IdText)")
                            
                        }
                    }
                    
                    
                }
            })
        }
        
        completeSignInWithFaceOrTwitter(id: userDataRetrived.userID, userData: userDataRetrived)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        print("loginButtonDidLogOut is tapped")
        
        
        
    }
    
    func startFirebaseAuthProcess(credentialTakenFromFacebook : AuthCredential){
        
        Auth.auth().signIn(with: credentialTakenFromFacebook) { (user, error) in
            
            if error != nil {
                
                if let errorMessage = error as NSError? {
                    
                    print("Erkut : firebase sign in has failed, errorMessage :\(errorMessage.userInfo)")
                    print("Erkut : firebase sign in has failed, errorMessage :\(errorMessage.localizedDescription)")
                    
                }
                
            } else {
                
                print("Erkut : Firebase user signed up !")
                
            }
        }
    }
    
    
    
    func takasi() {
        
        print("takasi starts")
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            
            print("takasi bombom")
            
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
        self.customButton.addSubview(logInButton)

        
        
    }
    
    func takasi_2() {
        
        let imageAttachment =  NSTextAttachment()
        //imageAttachment.image = UIImage(named:"ic_mail.png")
        imageAttachment.image = UIImage(named: "ic_mail")
        //Set bound to reposition
        let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        //Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        //Add image to mutable string
        completeText.append(attachmentString)
        //Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string: "erkut")
        completeText.append(textAfterIcon)
        self.emailField.textAlignment = .center;
        self.emailField.attributedText = completeText;
    }
    
}


