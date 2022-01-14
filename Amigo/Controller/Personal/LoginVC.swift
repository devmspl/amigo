//
//  LoginVC.swift
//  Amigo
//
//  Created by Macbook on 14/10/21.
//

import UIKit
import MBProgressHUD

class LoginVC: UIViewController {

    @IBOutlet  var socialView: [UIView]!
    @IBOutlet var textViews: [UIView]!
    @IBOutlet weak var phoneNo: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
 //MARK: - DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
       background()
        back2()
        password.isSecureTextEntry = true
        for i in 0...textViews.count-1{
            textViews[i].layer.cornerRadius = 10
            textViews[i].layer.borderWidth = 1
            textViews[i].layer.borderColor = UIColor.white.cgColor
        }
        loginBtn.layer.cornerRadius = 10
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
           gradientLayer.frame = self.loginBtn.bounds
                   
           self.loginBtn.layer.insertSublayer(gradientLayer, at:0)
    }
    
//MARK:- BUTTON ACTIONS
    
    @IBAction func forgot_pass(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPassVC") as! ForgotPassVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func loginTapped(_ sender: Any) {
        if phoneNo.text == ""{
            self.alert(message: "Please enter Email")
        }else if password.text == ""{
            self.alert(message: "Please enter password")
        }else if !(isValidEmail(phoneNo.text!)){
            self.alert(message: "Please enter valid email")
        }else{
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let loginModel = LoginModel(email: phoneNo.text!, password: password.text!)
            ApiManager.shared.login(model: loginModel) { (isSuccess) in
                if isSuccess{
                    MBProgressHUD.hide(for: self.view, animated: true)
                    print(UserDefaults.standard.value(forKey: "Gender"),"ftyfytfytfytfytf")
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "GenderVC") as! GenderVC
//                    self.navigationController?.pushViewController(vc, animated: true)
                    if UserDefaults.standard.value(forKey: "Gender") as! String  == ""{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GenderVC") as! GenderVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                    
                }else{
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.alert(message: ApiManager.shared.message)
                }
            }
        }
        
        
    }
    @IBAction func showPassword(_ sender: Any) {
        if password.isSecureTextEntry == true{
            password.isSecureTextEntry = false
        }else{
            password.isSecureTextEntry = true
        }
    }
    @IBAction func googleTapped(_ sender: Any) {
        print("hello")
    }
    @IBAction func facebookTapped(_ sender: Any) {
        print("helloeffds")
    }
    @IBAction func back_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func signUpTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVc") as! SignupVc
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

