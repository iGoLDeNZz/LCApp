//
//  homeVC.swift
//  LCApp
//
//  Created by YAZEED NASSER on 16/10/2018.
//  Copyright © 2018 LawClub. All rights reserved.
//

import UIKit

class homeVC: UIViewController {
    
    var _account:account = account.init(accountType: "", email: "", pass: "", uid: "")
    
    @IBOutlet weak var screenCoverdBtn: UIButton!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var CurveImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        hideMenu()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func menuBtnPressed(_ sender: Any) {
        showMenue()
    }
    @IBAction func DarkViewTapped(_ sender: Any) {
        hideMenu()
        //        self.dismiss(animated: false, completion: nil)
        
    }
    
    func hideMenu(){
        UIView.animate(withDuration: 0.4, animations: {
            self.menuView.alpha = 0
            self.screenCoverdBtn.alpha = 0
        })
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.CurveImageView.transform = CGAffineTransform(translationX: self.CurveImageView.frame.width, y: 0)
            
        })
    }
    
    func showMenue(){
        UIView.animate(withDuration: 0.4, animations: {
            self.menuView.alpha = 0.95
            self.screenCoverdBtn.alpha = 0.5
        })
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.CurveImageView.transform = .identity //the default value
        })
    }
    
    @IBAction func homeBtnPressed(_ sender: Any) {
        hideMenu()
    }
    @IBAction func profileBtnPressed(_ sender: Any) {
        hideMenu()
        self.performSegue(withIdentifier: "profileVC", sender: nil)
        
    }
    @IBAction func ourAccountsBtnPressed(_ sender: Any) {
        hideMenu()
        self.performSegue(withIdentifier: "outAccountsVC", sender: nil)
    }
    @IBAction func moreInfoBtnPressed(_ sender: Any) {
        hideMenu()
        self.performSegue(withIdentifier: "moreInfoVC", sender: nil)
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
