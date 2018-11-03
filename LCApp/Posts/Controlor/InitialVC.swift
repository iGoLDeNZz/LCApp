//
//  InitialVC.swift
//  LCApp
//
//  Created by YAZEED NASSER on 16/10/2018.
//  Copyright © 2018 LawClub. All rights reserved.
//

import UIKit
import Firebase
var dbRef: DatabaseReference = Database.database().reference()

class InitialVC: UIViewController {
    
    @IBOutlet weak var acctivityViewicon: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UserDefaults.standard.set(false, forKey: "logedInFK")
        
        //rread from the userDefault
        acctivityViewicon.startAnimating()
        
        if  UserDefaults.standard.bool(forKey: "logedInFK") == true {
            updateCurrentUserDefault(boolVal: true)
            Auth.auth().signIn(withEmail: currentUserInfo._email , password: currentUserInfo._pass ) { user, error in
                if error == nil && user != nil {
                    //no Error with AutoLogIn
                } else {
                    print("Error logging in: \(error!.localizedDescription)")
                }
            }
        }//end autoLogIn
        
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

//set new userDefault
func setUserDeafultFK(boolVal:Bool,Acc:account){
    UserDefaults.standard.set(boolVal, forKey: "logedInFK")//true:Logedin or false:LogedOut
    UserDefaults.standard.set(Acc, forKey: "userAccFK")
    updateCurrentUserDefault(boolVal: boolVal)
}

//set userDefault&updateCurrentAcc
func updateCurrentUserDefault(boolVal:Bool) {
    //update info if the user is logedin
    if boolVal == true {
        currentUserInfo = UserDefaults.standard.object(forKey: "userAccFK") as! account
        dbRef.child("Accounts").child(currentUserInfo._uid).observeSingleEvent(of: .value, with: { snapshot in
            
            if  let dect = snapshot.value as? [String:Any],
                let ـaccountType = dect["accountType"] as? String,
                let _password = dect["passWord"] as? String,
                let _email = dect["email"] as? String,
                
                let _uid = dect["uid"] as? String
            {
                currentUserInfo = account.init(accountType:ـaccountType,email: _email ,pass: _password, uid : _uid)
            }
        })
    }
}

