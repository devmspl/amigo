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
//MARK:- BUTTON ACTIONS
    
    @IBAction func forgot_pass(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPassVC") as! ForgotPassVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func loginTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GenderVC") as! GenderVC
        
        self.navigationController?.pushViewController(vc, animated: true)
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
