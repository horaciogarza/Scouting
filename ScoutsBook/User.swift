//
//  User.swift
//  ScoutsBook
//
//  Created by Abraham Barcenas M on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import Foundation

class User {
    let UserPin : Int
    let Email : String
    let Password : String
    let Name : String
    let ProfilePicture : String?
    let Level : Int
    let Stars : Int
    let CreationDate : String
    let LastLogin : String?
    
    
    init(UserPin: Int, Email: String, Password: String, Name: String, Level: Int, CreationDate : String) {
        self.UserPin = UserPin
        self.Email = Email
        self.Password = Password
        self.Name = Name
        self.ProfilePicture = nil
        self.Level = 0
        self.Stars = 0
        self.CreationDate = CreationDate
        self.LastLogin = nil
    }
    
}
