//
//  account.swift
//  LCApp
//
//  Created by YAZEED NASSER on 16/10/2018.
//  Copyright © 2018 LawClub. All rights reserved.
//

import Foundation
class account{
    var _accountType:String! //(Admin/user) account
    var _email:String!
    var _pass:String!
    var _uid : String!
    var _attendedEvents: [Event]!
    //Exta information VV (name , ...)
    
    init(accountType:String,email:String,pass:String!, uid : String){
        _accountType    = accountType
        _email          = email
        _pass           = pass
        _uid            = uid
        _attendedEvents = [Event]();
    }
}
