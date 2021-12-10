//
//  ForgotPassVC.swift
//  Amigo
//
//  Created by Macbook on 14/10/21.
//

import UIKit
import MBProgressHUD

class ForgotPassVC: UIViewController {

    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
background()
        back2()
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

    func back2(){
        let colorTop =  UIColor(red: 169.0/255.0, green: 8.0/255.0, blue: 49.0/255.0, alpha: 1.0).cgColor
//        let colorCenter = UIColor(red: 246.0/255.0, green: 94.0/255.0, blue: 126.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 243.0/255.0, green: 93.0/255.0, blue: 131.0/255.0, alpha: 1.0).cgColor
                       
           let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = 10
           gradientLayer.colors = [colorTop, colorBottom]
           gradientLayer.locations = [0.0, 1.0]
           gradientLayer.frame = self.forgotPassword.bounds
                   
           self.forgotPassword.layer.insertSublayer(gradientLayer, at:0)
    }
    
    @IBAction func back_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func forgotPassword(_ sender: Any) {
        if emailText.text == ""{
            self.alert(message: "Please enter email")
        }else if isValidEmail(emailText.text!){
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let model = ForgotPassModel(email: emailText.text!)
            ApiManager.shared.forgetApi(model: model) { success in
                if success{
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    MBProgressHUD.hide(for: self.view, animated: true)
                    print("Hello there in an error please check")
                }
            }
        }else{
           
            alert(message: "please enter valid email")
        }
      
        
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
