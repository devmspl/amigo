//
//  GenderVC.swift
//  Amigo
//
//  Created by mac on 21/10/2021.
//

import UIKit

class GenderVC: UIViewController {

//MARK:- OUTLETS
    
    @IBOutlet var btnView: [UIView]!
//MARK:- VIEWDID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        background()
        for i in 0...btnView.count-1{
            btnView[i].layer.cornerRadius = 15
            btnView[0].layer.borderWidth = 1
            btnView[0].layer.borderColor = UIColor(named: "manColor")?.cgColor
            btnView[1].layer.backgroundColor = UIColor(named: "girlColor")?.cgColor
            btnView[0].layer.backgroundColor = UIColor.clear.cgColor
        }
    }
// MARK:- BACKGROUND COLOR
    func background(){
        let colorTop =  UIColor(red: 37.0/255.0, green: 50.0/255.0, blue: 116.0/255.0, alpha: 1.0).cgColor
        let colorCenter = UIColor(red: 246.0/255.0, green: 94.0/255.0, blue: 126.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 211.0/255.0, green: 80.0/255.0, blue: 190.0/255.0, alpha: 1.0).cgColor
                       
           let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [colorTop, colorCenter, colorBottom]
           gradientLayer.locations = [0.0, 1.0]
           gradientLayer.frame = self.view.bounds
                   
           self.view.layer.insertSublayer(gradientLayer, at:0)
    }
//MARK:- BUTTON ACTIONS
    @IBAction func maleTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalInformation1VC") as! PersonalInformation1VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func womenTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalInformation1VC") as! PersonalInformation1VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
