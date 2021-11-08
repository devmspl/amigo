//
//  SignupVc.swift
//  Amigo
//
//  Created by Macbook on 14/10/21.
//

import UIKit

class SignupVc: UIViewController {

    @IBOutlet var viewCollection: [UIView]!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var phoneNo: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var signupBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        background()
        
        for i in 0...viewCollection.count-1{
            viewCollection[i].layer.cornerRadius = 10
            viewCollection[i].layer.borderWidth = 1
            viewCollection[i].layer.borderColor = UIColor.white.cgColor
        }
       
        signupBtn.layer.cornerRadius = 20
        btnColor()
    }
//MARK:- VIEW BACKGROUND
    
    func background(){
        let colorTop =  UIColor(red: 37.0/255.0, green: 50.0/255.0, blue: 116.0/255.0, alpha: 1.0).cgColor
        let colorCenter = UIColor(red: 246.0/255.0, green: 94.0/255.0, blue: 126.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 211.0/255.0, green: 80.0/255.0, blue: 190.0/255.0, alpha: 1.0).cgColor
                       
           let gradientLayer = CAGradientLayer()
           gradientLayer.colors = [colorTop, colorCenter, colorBottom]
           gradientLayer.locations = [0.0, 1.0]
           gradientLayer.frame = self.view.bounds
                   
           self.mainView.layer.insertSublayer(gradientLayer, at:0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
//MARK:- BTN COLOR
    func btnColor(){
        let upColor = UIColor(red: 169.0/255.0, green: 8.0/255.0, blue: 49.0/255.0, alpha: 1)
        let downColor = UIColor(red: 243.0/255.0, green: 93.0/255.0, blue: 131.0/255.0, alpha: 1)
        
        let gradient = CAGradientLayer()
        gradient.colors = [upColor, downColor]
//        gradient.locations = [0.0,1.0]
        gradient.frame = self.signupBtn.bounds
        self.signupBtn.layer.insertSublayer(gradient, at: 0)
    }
    
//MARK:- BTN ACTIONS
    
    @IBAction func login_tapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func signUptapped(_ sender: Any) {
        print("hello")
    }
    @IBAction func eye1(_ sender: Any) {
        if   password.isSecureTextEntry == true{
            password.isSecureTextEntry = false
        }else{
            password.isSecureTextEntry = true
        }
    }
    
    @IBAction func eye2(_ sender: Any) {
        if   confirmPassword.isSecureTextEntry == true{
            confirmPassword.isSecureTextEntry = false
        }else{
            confirmPassword.isSecureTextEntry = true
        }
    }
    
}
