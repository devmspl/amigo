//
//  ProfileVC.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var seprator: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
            seprator.isHidden = false
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
            seprator.isHidden = true
//            self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
    }
    
    @IBAction func imageChange(_ sender: Any) {
    }
    
}
