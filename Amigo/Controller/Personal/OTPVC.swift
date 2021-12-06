//
//  OTPVC.swift
//  Amigo
//
//  Created by mac on 26/10/2021.
//

import UIKit

class OTPVC: UIViewController {

    @IBOutlet weak var otpText: UITextField!
    @IBOutlet weak var nextButton: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
background()
        nextButton.layer.cornerRadius = 30
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


    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func continueTapped( _ sender: UIButton){
        let model = OTPModel(otp: otpText.text)
        ApiManager.shared.otpApi(model: model) { (issuccess) in
            if issuccess{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                print("Completion false please check why")
            }
        }
       
    }

    @IBAction func resendCode(_ sender: Any) {
    }
}
