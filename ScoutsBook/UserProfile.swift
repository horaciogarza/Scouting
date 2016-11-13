//
//  UserProfile.swift
//  ScoutsBook
//
//  Created by Horacio Garza on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import Foundation

class UserProfile{
    
    var name: String!
    var level: Int!
    var levelTo: Int!
    var progress: String!
    var totalFound: Int!
    
    
    init(name: String, level: Int, levelTo: Int, progress:String, totalFound: Int){
        
        self.name = name
        self.level = level
        self.levelTo = levelTo
        self.progress = progress
        self.totalFound = totalFound
        
    }
    
    func getNameFromDB() -> String{
        let nameFromDB = ""
        
        return nameFromDB
    }
    
    func getLevelFromDB() -> Int{
        let nameFromDB = 0
        
        return nameFromDB
    }
    
    func getLevelToFromDB() -> Int{
        let nameFromDB = 1
        
        return nameFromDB
    }
    
    func getProgressFromDB() -> Int{
        let nameFromDB = 0
        
        return nameFromDB
    }
    
    func totalFoundFromDB() -> Int{
        let nameFromDB = 0
        
        return nameFromDB
    }
    
}
