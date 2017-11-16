//
//  UserStructure.swift
//  selfLoginTest
//
//  Created by Erkut Baş on 11/11/2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import Foundation
import Firebase

class UserStructure {
    
    private var _userID : String
    private var _userEmail : String
    
    
    var userID : String {
        
        return _userID
        
    }
    
    var userEmail : String {
        
        return _userEmail
        
    }
    
    init() {
        
        self._userID = ""
        self._userEmail = ""
        
    }
    
    init(userID : String, userEmail : String) {
        
        self._userID = userID
        self._userEmail = userEmail
        
    }
    
    func setUserID(userID : String) {
        
        self._userID = userID
        
    }
    
    func setEmailAddress(email : String) {
        
        self._userEmail = email
    }
    
}
