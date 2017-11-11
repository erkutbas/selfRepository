//
//  Users.swift
//  selfLoginTest
//
//  Created by Erkut Baş on 11/11/2017.
//  Copyright © 2017 Erkut Baş. All rights reserved.
//

import Foundation
import Firebase

class Users {
    
    private var userDictionary : Dictionary<String, String> = [:]
    
    init() {
        
        userDictionary = [:]
        
    }
    
    func addUserData(userInfo : UserStructure) {
        
        userDictionary["email"] = userInfo.userEmail
        
    }
    
    func getUserDataAsDictionary() -> Dictionary<String, String>{
        
        return userDictionary
        
    }
    
}
