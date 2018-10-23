//
//  RoundedBtn.swift
//  LCApp
//
//  Created by YAZEED NASSER on 16/10/2018.
//  Copyright © 2018 LawClub. All rights reserved.
//

import UIKit

class RoundedBtn: UIButton {
    override func awakeFromNib() {

        self.alpha = 0.9
        self.layer.cornerRadius = 20
        self.setTitleColor(UIColor.white, for: .normal)
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
        self.layer.shadowRadius = 5
        
    }
 

}
