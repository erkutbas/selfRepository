//
//  mainView.swift
//  selfLoginTest
//
//  Created by Erkut Baş on 07/11/2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import UIKit

class mainView: UIView {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        
        
        layer.shadowColor = UIColor.black.cgColor
        
        layer.shadowOpacity = 50.0
        layer.shadowRadius = 50.0
        layer.shadowOffset = CGSize(width:  10.0, height: 10.0)
        
        layer.cornerRadius = 10.0
        
    }

}
