//
//  ForgotPassVC.swift
//  Amigo
//
//  Created by Macbook on 14/10/21.
//

import UIKit

class ForgotPassVC: UIViewController {

    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
background()
        emailText.layer.borderWidth = 1
        emailText.layer.borderColor = UIColor.white.cgColor
        emailText.layer.cornerRadius = 10
        forgotPassword.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
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

    @IBAction func back_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func forgotPassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
