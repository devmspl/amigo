//
//  ResetPasswordVC.swift
//  Amigo
//
//  Created by mac on 26/10/2021.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet var textViews: [UIView]!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var btnView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        background()
        
        for i in 0...textViews.count-1{
            textViews[i].layer.cornerRadius = 10
            textViews[i].layer.borderWidth = 1
            textViews[i].layer.borderColor = UIColor.white.cgColor
        }
        btnView.layer.cornerRadius = 20
      
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


    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eye1(_ sender: Any) {
        if newPassword.isSecureTextEntry == true{
            newPassword.isSecureTextEntry = false
        }else{
            newPassword.isSecureTextEntry = true
        }
    }
    @IBAction func eye2(_ sender: Any) {
        if confirmPassword.isSecureTextEntry == true{
            confirmPassword.isSecureTextEntry = false
        }else{
            confirmPassword.isSecureTextEntry = true
        }
    }
    @IBAction func resetTapped(_ sender: Any) {
        if newPassword.text != confirmPassword.text{
            self.alert(message: "Password Mismatch")
        }else{
            let model = ResetPassModel(newPassword: newPassword.text)
            ApiManager.shared.resetPassword(model: model) { (issuccess) in
                if issuccess{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    print("completion false")
                }
            }
        }
    }
}
