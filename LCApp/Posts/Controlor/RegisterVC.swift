//
//  RegisterVC.swift
//  LCApp
//
//  Created by YAZEED NASSER on 16/10/2018.
//  Copyright © 2018 LawClub. All rights reserved.
//

import UIKit
import Firebase

class RegesterVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    //database ref
    var dbRef: DatabaseReference = Database.database().reference()
    
   

    @IBOutlet weak var accMemID: UITextField!
    var StuKSUemail:String = "@student.ksu.edu.sa"
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPwdTxt: UITextField!
    
    var TypeVal = "Normal"
    let TypesArr:[String] = ["Normal","Admin"]
    @IBOutlet weak var TypeBtn: UIButton!
    @IBOutlet weak var TypePik: UIPickerView!
    
   
    
    @IBOutlet weak var regesterBtn: UIButton!
    @IBOutlet weak var CancelBtn: UIButton!
    @IBOutlet weak var BGDarkView: UIView!
    var activityView:UIActivityIndicatorView!
    
    
    @IBOutlet weak var erorrLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    
        regesterBtn.backgroundColor = GoButtenColor
        CancelBtn.backgroundColor = BackButtenColor
        
        //acctiveity for the Register
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        activityView.frame = CGRect(x: 0, y: 0, width: 500.0, height: 500.0)
        activityView.center  = CGPoint(x: (view.frame.width/2), y: (view.frame.height/2))
        
        BGDarkView.addSubview(activityView)
        
        // Do any additional setup after loading the view.
        TypePik.dataSource = self
        TypePik.delegate = self
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //fix it!!
    @IBAction func cancelBtnPressed
        (_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func intrestBtnPressed(_ sender: Any) {
        TypeBtn.isHidden = true
        TypePik.isHidden = false
    }

    
    @IBAction func regesterBtnPressed(_ sender: Any) {
        let memID:String = accMemID.text!
        let userType:String = TypeVal
        let password:String = passwordTxt.text!
        let confirmPwd:String = confirmPwdTxt.text!
        var emailGenrater:String = ""
        
        //chek input
        if (TypeVal != "" && memID != "" && password != "") {
            if (password != confirmPwd) {
                emailGenrater = "\(memID)\(StuKSUemail)"
                showErorr(reson: "password does not match the confirm password")
            } else {
                let userAccount = account.init( accountType: TypeVal, email: emailGenrater, pass: password, uid : "")
                    //segue >> home
                    self.authAccRegister(acc: userAccount)
                 
            }
        }else{
            showErorr(reson: "Enter all informatin below!")
            
        }
        
    }
    //Firebase Funcs vvv
    func authAccRegister(acc:account) {
        
        //start activity & disable buttens & enabel darkView
        self.setRegisterAndCancelButton(enabled: false)
        activityView.startAnimating()
        
        Auth.auth().createUser(withEmail: acc._email, password: acc._pass) { user, error in
            if error == nil && user != nil {
                print("Account created!")
                acc._uid = (Auth.auth().currentUser?.uid)!
                
                let data = [
                    "uid" : acc._uid,
                    "email" : acc._email,
                    "accountType" : acc._accountType,
                    "passWord" : acc._pass,
                    
                    ] as [String:String]
                
                self.dbRef.child("Accounts").child( (Auth.auth().currentUser?.uid)! ).setValue(data)
//                account.setAccInfo(acc: acc)
                
                //stop activity & enabel buttens & disabel darkView
                self.activityView.stopAnimating()
                self.setRegisterAndCancelButton(enabled: true)
                
                self.performSegue(withIdentifier: "HomeVC", sender: acc)
                
            } else {
                if "\(error!.localizedDescription)" == "Network error (such as timeout, interrupted connection or unreachable host) has occurred."{
                    self.showErorr(reson: "Check your connection bro ;)")
                }else{
                    self.showErorr(reson: "\(error!.localizedDescription)")
                    
                }
                
                //stop activity & enabel buttens & disabel darkView
                self.activityView.stopAnimating()
                self.setRegisterAndCancelButton(enabled: true)
            }
        }
    }
    //func to show error
    func showErorr(reson:String ){
        regesterBtn.shake()
        erorrLbl.text = reson
        UIView.animate(withDuration: 2, animations: {
            self.erorrLbl.alpha = 8
        })
        UIView.animate(withDuration: 2, animations: {
            self.erorrLbl.alpha = 0
        })
        
    }
    //signin button & cancel buttn (disable/enable)
    func setRegisterAndCancelButton(enabled:Bool) {
        if enabled {
            BGDarkView.isHidden = true
            regesterBtn.alpha = 1.0
            regesterBtn.isEnabled = true
            CancelBtn.alpha = 1.0
            CancelBtn.isEnabled = true
        } else {
            BGDarkView.isHidden = false
            regesterBtn.alpha = 0.5
            regesterBtn.isEnabled = false
            CancelBtn.alpha = 0.5
            CancelBtn.isEnabled = false
        }
    }
    //pikers code
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return TypesArr.count
       
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
            return String(TypesArr[row])
       
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
            TypeBtn.setTitle(String(TypesArr[row]), for: UIControlState.normal)
            TypeVal = String(TypesArr[row])
            TypePik.isHidden = true
            TypeBtn.isHidden = false
        
        
    }
    
    //segue (nevgating to the home page)
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
