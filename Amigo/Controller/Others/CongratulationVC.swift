//
//  CongratulationVC.swift
//  Amigo
//
//  Created by mac on 19/11/2021.
//

import UIKit

class CongratulationVC: UIViewController {

    @IBOutlet weak var firstImgView: UIView!
    @IBOutlet weak var secondimgView: UIView!
    @IBOutlet weak var firstimg: UIImageView!
    @IBOutlet weak var secondImg: UIImageView!
    @IBOutlet weak var msgView: UIView!
    @IBOutlet weak var msgText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        firstImgView.layer.cornerRadius = 50
        firstimg.layer.cornerRadius = 50
        firstImgView.layer.borderWidth = 3
        firstImgView.layer.borderColor = UIColor(named: "girlColor")?.cgColor
        
        secondImg.layer.cornerRadius = 50
        secondimgView.layer.cornerRadius = 50
        secondimgView.layer.borderWidth = 3
        secondimgView.layer.borderColor = UIColor(named: "manColor")?.cgColor
        
   
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
//          self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
    }
    
    @IBAction func MsgTapped(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
