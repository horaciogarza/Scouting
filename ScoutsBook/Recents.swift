//
//  Recents.swift
//  ScoutsBook
//
//  Created by Abraham Barcenas M on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import Foundation
import Firebase

class Recents {
    let UserPin : Int
    let Image : String
    let Fecha : String
    let Decripcion : String
    let ref : FIRDatabaseReference?
    
    init(UserPin: Int, Image: String, Fecha: String, Decripcion: String){
        self.UserPin = UserPin
        self.Image = Image
        self.Fecha = Fecha
        self.Decripcion = Decripcion
    }
    
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        UserPin = snapshotValue["UserPin"] as! Int
        Image = snapshotValue["Image"] as! String
        Fecha = snapshotValue["Fecha"] as! String
        Description = snapshotValue["Descripcion"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "UserPin": UserPin,
            "Image": Image,
            "Fecha": Fecha,
            "Descripcion": Descripcion
        ]
    }
}
