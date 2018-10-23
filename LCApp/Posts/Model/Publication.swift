//
//  Publication.swift
//  LCApp
//
//  Created by Yousef At-tamimi on 10/23/18.
//  Copyright © 2018 LawClub. All rights reserved.
//

import Foundation

class Publication{
    
    var _tital:String!
    var _content:String!
    var _issueDate:String!
    var _owner:account!
    var _pubID:String!
    
    init(tital:String, content:String, issueDate:String, owner:account, pubID:String){
        
        _tital      = tital
        _content    = content
        _issueDate  = issueDate
        _owner      = owner
        _pubID      = pubID
    }
    
    
}
