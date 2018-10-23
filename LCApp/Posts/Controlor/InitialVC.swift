//
//  InitialVC.swift
//  LCApp
//
//  Created by YAZEED NASSER on 16/10/2018.
//  Copyright © 2018 LawClub. All rights reserved.
//

import UIKit
import Firebase

class InitialVC: UIViewController {
    @IBOutlet weak var acctivityViewicon: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //- Todo: Check if user is authenticated(signed in). If so, segue to the HomeVC, otherwise, segue to the WelcomeVC
        acctivityViewicon.startAnimating()
        self.performSegue(withIdentifier: "homeVC", sender: self)
        acctivityViewicon.stopAnimating()
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
