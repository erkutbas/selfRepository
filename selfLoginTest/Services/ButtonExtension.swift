//
//  ButtonExtension.swift
//  selfLoginTest
//
//  Created by Erkut Baş on 12/11/2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setBorders()
    {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
    
    func setBackgroundColorAlpha5() {
        
        layer.backgroundColor = UIColor(white: 1, alpha: 0.5).cgColor
    
    }
    
    func setBackgroundColorAlpha1() {
        
        layer.backgroundColor = UIColor(white: 1, alpha: 0.1).cgColor
        
    }
    
}

