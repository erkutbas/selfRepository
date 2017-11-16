//
//  startLoginOrSigninViewController.swift
//  selfLoginTest
//
//  Created by Erkut Baş on 12/11/2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit

class StartLoginOrSigninViewController: UIViewController {

    @IBOutlet var loginButton: buttonView!
    @IBOutlet var signinButton: buttonView!
    @IBOutlet var mainImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setButtonBorders()
        setButtonBackgroundColor()
        getScreenBlur()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setButtonBorders()
        setButtonBackgroundColor()
        
        disableRootNavigationBar()
    }
    
    private func setButtonBorders() {
        
        self.loginButton.setBorders()
        self.signinButton.setBorders()
        
    }
    
    private func setButtonBackgroundColor() {
        
        self.loginButton.setBackgroundColorAlpha5()
        self.signinButton.setBackgroundColorAlpha1()
    }
    
    private func disableRootNavigationBar() {
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func enableRootNavigationBar() {
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func getScreenBlur() {
        
        //let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = mainImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainImage.addSubview(blurEffectView)
        
    }
    
    /*
     action functions .....
     */
    @IBAction func loginButton(_ sender: Any) {
        
        performSegue(withIdentifier: "gotoLoginView", sender: self)
        
    }
    
    @IBAction func createAccountButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "gotoSigninView", sender: self)
        
    }

}




