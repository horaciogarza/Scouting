//
//  Users.swift
//  MySampleApp
//
//
// Copyright 2016 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-swift v0.5
//

import Foundation
import UIKit
import AWSDynamoDB

class Users: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _level: NSNumber?
    var _name: String?
    var _nextLevel: NSNumber?
    var _progress: NSNumber?
    var _totalFound: NSNumber?
    
    class func dynamoDBTableName() -> String {

        return "scoutsbook-mobilehub-1038912412-Users"
    }
    
    class func hashKeyAttribute() -> String {

        return "_userId"
    }
    
    class func jsonKeyPathsByPropertyKey() -> [NSObject : AnyObject] {
        return [
               "_userId" as NSObject : "userId" as AnyObject,
               "_level" as NSObject : "level" as AnyObject,
               "_name" as NSObject : "name" as AnyObject,
               "_nextLevel" as NSObject : "nextLevel" as AnyObject,
               "_progress" as NSObject : "progress" as AnyObject,
               "_totalFound" as NSObject : "totalFound" as AnyObject,
        ]
    }
}