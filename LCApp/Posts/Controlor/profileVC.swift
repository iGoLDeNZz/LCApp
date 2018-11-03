//
//  profileVC.swift
//  LCApp
//
//  Created by YAZEED NASSER on 20/10/2018.
//  Copyright © 2018 LawClub. All rights reserved.
//

import UIKit

class profileVC: UIViewController {
    @IBOutlet weak var NavAccName: UILabel!
    @IBOutlet weak var accName: UILabel!
    @IBOutlet weak var AccMemID: UILabel!
    @IBOutlet weak var ScoreBtn: RoundedBtn!
    @IBOutlet weak var PointsBtn: RoundedBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateProfileView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)

    }
    @IBAction func creatNewMemBtn(_ sender: Any) {
        
    }
    
    //additional Funcs
    func updateProfileView(){
        NavAccName.text = currentUserInfo.name
        accName.text = currentUserInfo.name
        AccMemID.text = currentUserInfo._email
        ScoreBtn.titleLabel?.text = "0"
        PointsBtn.titleLabel?.text = "0"
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
