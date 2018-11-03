//
//  LogInVC.swift
//  LCApp
//
//  Created by YAZEED NASSER on 16/10/2018.
//  Copyright © 2018 LawClub. All rights reserved.
//
import Foundation
import UIKit
import Firebase

class LogInVC: UIViewController {
    //Firebase ref
    var dbRef: DatabaseReference = Database.database().reference()
    
    @IBOutlet weak var memIDTxt: UITextField!
    @IBOutlet weak var passWordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var erorrLbl: UILabel!
    @IBOutlet weak var BGDarkView: UIView!
    var accounts:[account]! = []
    var activityView:UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        loginBtn.backgroundColor = GoButtenColor
        backBtn.backgroundColor = BackButtenColor
        
        //acctiveity for the signin
        activityView = UIActivityIndicatorView(style: .gray)
        activityView.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        activityView.frame = CGRect(x: 0, y: 0, width: 500.0, height: 500.0)
        activityView.center  = CGPoint(x: (view.frame.width/2), y: (view.frame.height/2))
        //        activityView.center = loginBtn.center
        BGDarkView.isHidden = true
        BGDarkView.addSubview(activityView)
        
        
        // Do any additional setup after loading the view.
        
        //Testing VV
        memIDTxt.text = "test1122"
        passWordTxt.text = "test1122"
        self.loginBtnPressed(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //need to fix VVVV
    @IBAction func cancelBtnPressed(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        var email = memIDTxt.text!
        let password = passWordTxt.text!
        
        if email != "" && password != "" {
            email = "\(email)@gmail.com"
            self.authAccLogin(email:email,password: password)
        }else {
            //displayErorr (enter username and password)
            showErorr(reson: "enter username and password!")
        }
    }
    //Firebase code VVV
    func authAccLogin(email:String, password:String){
        self.setLoginAndCancelButton(enabled: false)
        activityView.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                self.dbRef.child("Accounts").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { snapshot in
    
                    if  let dect = snapshot.value as? [String:Any],
                        let ـaccountType = dect["accountType"] as? String,
                        let _password = dect["passWord"] as? String,
                        let _email = dect["email"] as? String,
                        let _uid = dect["uid"] as? String
                    {

                        let accountOfTheUser:account! = account.init(accountType:ـaccountType,email: _email ,pass: _password, uid : _uid)
                    
                        //set default value
                        setUserDeafultFK(boolVal: true,Acc: accountOfTheUser)
                       
                        self.activityView.stopAnimating()
                        self.setLoginAndCancelButton(enabled: true)
                        self.dismiss(animated: true, completion: nil)
//                        self.performSegue(withIdentifier: "profileVC", sender: accountOfTheUser)
                    }
                })
            } else {
                if "\(error!.localizedDescription)" == "Network error (such as timeout, interrupted connection or unreachable host) has occurred."{
                    self.showErorr(reson: "Check your connection bro ;)")
                }else{
                    self.showErorr(reson: "\(error!.localizedDescription)")
                }
                
                self.activityView.stopAnimating()
                self.setLoginAndCancelButton(enabled: true)
                
            }
        }
    }
    
    //func to show error
    func showErorr(reson:String ){
        loginBtn.shake()
        erorrLbl.text = reson
        UIView.animate(withDuration: 2, animations: {
            self.erorrLbl.alpha = 8
        })
        UIView.animate(withDuration: 2, animations: {
            self.erorrLbl.alpha = 0
        })
        
    }
    
    //Login button & cancel buttn (disable/enable)
    func setLoginAndCancelButton(enabled:Bool) {
        if enabled {
            BGDarkView.isHidden = true
            loginBtn.alpha = 1.0
            loginBtn.isEnabled = true
            backBtn.alpha = 1.0
            backBtn.isEnabled = true
        } else {
            BGDarkView.isHidden = false
            loginBtn.alpha = 0.5
            loginBtn.isEnabled = false
            backBtn.alpha = 0.5
            backBtn.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destnation = segue.destination as? homeVC {
            if let account = sender as? account{
                destnation._account = account
            }
            
        }
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
