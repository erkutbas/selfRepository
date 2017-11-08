//
//  buttonView.swift
//  selfLoginTest
//
//  Created by Erkut Baş on 08/11/2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit

class buttonView: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        layer.shadowColor = UIColor.white.cgColor
        
        layer.shadowOpacity = 50.0
        layer.shadowRadius = 50.0
        layer.shadowOffset = CGSize(width:  10.0, height: 10.0)
        
        layer.cornerRadius = 10.0
        
    }

}
