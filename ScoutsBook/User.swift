//
//  User.swift
//  ScoutsBook
//
//  Created by Abraham Barcenas M on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


class User {
    
    static let sharedInstance = User(UserPin: 0, Email: "", Password: "", Name: "", Level: 0, CreationDate: "")
    
    var key : String
    var UserPin : Int
    var Email : String
    var Password : String?
    var Name : String
    var ProfilePicture : String?
    var Level : Int
    var Stars : Int
    var CreationDate : String
    var LastLogin : String?
    var ref : FIRDatabaseReference?
    
    
    init(UserPin: Int, Email: String, Password: String?, Name: String, Level: Int, CreationDate : String) {
        self.key = ""
        self.UserPin = UserPin
        self.Email = Email
        self.Password = Password
        self.Name = Name
        self.ProfilePicture = nil
        self.Level = 0
        self.Stars = 0
        self.CreationDate = CreationDate
        self.LastLogin = nil
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        UserPin = snapshotValue["UserPin"] as! Int
        Email = snapshotValue["Email"] as! String
        Password = snapshotValue["Password"] as? String
        Name = snapshotValue["Name"] as! String
        ProfilePicture = snapshotValue["ProfilePicture"] as? String
        Level = snapshotValue["Level"] as! Int
        Stars = snapshotValue["Stars"] as! Int
        CreationDate = snapshotValue["CreationDate"] as! String
        LastLogin = snapshotValue["LastLogin"] as? String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "UserPin": UserPin,
            "Email": Email,
            "Password": Password,
            "Name": ProfilePicture,
            "ProfilePicture": ProfilePicture,
            "Level": Level,
            "Stars": Stars,
            "CreationDate": CreationDate,
            "LastLogin": LastLogin
        ]
    }
    
}
