//
//  account.swift
//  LCApp
//
//  Created by YAZEED NASSER on 16/10/2018.
//  Copyright © 2018 LawClub. All rights reserved.
//

import Foundation

////from the userDefaulte Value
//var logedInFK:Bool = false
//var passFK:String = ""
//var memEmailFK:String = ""
//var UidFK:String = ""

var currentUserInfo = account.init(accountType: "", email: "", pass: "", uid: "")

class account{
    var _accountType:String! // (Admin / normal) account
    let _email:String!
    var _pass:String!
    var _uid : String!
    //Exta information VV (name , ...)
    var name:String!
    var score:Int!
    
    
    
    init(accountType:String,email:String,pass:String!, uid : String){
        _accountType = accountType
        _email = email
        _pass=pass
        _uid = uid
    }
}
