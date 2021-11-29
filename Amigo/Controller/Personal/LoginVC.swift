//
//  LoginVC.swift
//  Amigo
//
//  Created by Macbook on 14/10/21.
//

import UIKit

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
        for i in 0...textViews.count-1{
            textViews[i].layer.cornerRadius = 10
            textViews[i].layer.borderWidth = 1
            textViews[i].layer.borderColor = UIColor.white.cgColor
        }
        loginBtn.layer.cornerRadius = 20
        if UserDefaults.standard.value(forKey: "id") != nil{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
//MARK:- BUTTON ACTIONS
    
    @IBAction func forgot_pass(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPassVC") as! ForgotPassVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func loginTapped(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GenderVC") as! GenderVC
//                        UserDefaults.standard.setValue(self.phoneNo.text!, forKey: "id")
//                        self.navigationController?.pushViewController(vc, animated: true)
        let loginModel = LoginModel(phoneNo: phoneNo.text!, password: password.text!)
        ApiManager.shared.login(model: loginModel) { (isSuccess) in
            if isSuccess{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "GenderVC") as! GenderVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.alert(message: "check credentials")
            }
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
    

}


extension UIViewController {
    
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
    
 // showAlertWithOneAction
 func showAlertWithOneAction(alertTitle:String, message: String, action1Title:String, completion1: ((UIAlertAction) -> Void)? = nil){
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: action1Title, style: .default, handler: completion1))
            self.present(alert, animated: true, completion: nil)
        }
    
//showAlertWithTwoActions
    func showAlertWithTwoActions(alertTitle:String, message: String, action1Title:String, action1Style: UIAlertAction.Style ,action2Title: String ,completion1: ((UIAlertAction) -> Void)? = nil,completion2 :((UIAlertAction) -> Void)? = nil){
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action1Title, style: action1Style, handler: completion1))
        alert.addAction(UIAlertAction(title: action2Title, style: .default, handler: completion2))
        self.present(alert, animated: true, completion: nil)
    }
}
