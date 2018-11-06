//
//  Event.swift
//  LCApp
//
//  Created by Yousef At-tamimi on 10/23/18.
//  Copyright © 2018 LawClub. All rights reserved.
//

import Foundation

class Event{
    
    var _tital:String!
    var _about:String!
    var _date:String!
    var _calendarLink:String?
    var _location:String!
    var _owner:account!
    var _eventID:String!
    
    init(tital:String, about:String, date:String, calendarLink:String, location:String, owner:account, eventID:String){
        
        _tital        = tital
        _about        = about
        _date         = date
        _calendarLink = calendarLink
        _location     = location
        _owner        = owner
        _eventID      = eventID
    }
    
    
}
