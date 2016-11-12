//
//  Recents.swift
//  ScoutsBook
//
//  Created by Abraham Barcenas M on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import Foundation

class Recents {
    let UserPin : Int
    let Image : String
    let Fecha : String
    let Decripcion : String
    
    init(UserPin: Int, Image: String, Fecha: String, Decripcion: String){
        self.UserPin = UserPin
        self.Image = Image
        self.Fecha = Fecha
        self.Decripcion = Decripcion
    }
    
}
