//
//  ChangePassword.swift
//  Amigo
//
//  Created by mac on 08/12/2021.
//

import UIKit

class ChangePassword: UIViewController {

    @IBOutlet var ViewsColl: [UIView]!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var changePassword: UITextField!
    @IBOutlet weak var changeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oldPassword.isSecureTextEntry = true
        newPassword.isSecureTextEntry = true
        changePassword.isSecureTextEntry = true
        
        for i in 0...ViewsColl.count-1{
            ViewsColl[i].layer.borderWidth = 1
            ViewsColl[i].layer.borderColor = UIColor.gray.cgColor
        }
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
            self.changeBtn.backgroundColor = UIColor(named: "girlButton")
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func forgetPassword(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPassVC") as! ForgotPassVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func showOld(_ sender: Any) {
        if oldPassword.isSecureTextEntry == true{
            oldPassword.isSecureTextEntry = false
        }else{
            oldPassword.isSecureTextEntry = true
        }
    }
    
    @IBAction func showNew(_ sender: Any) {
        if newPassword.isSecureTextEntry == true{
            newPassword.isSecureTextEntry = false
        }else{
            newPassword.isSecureTextEntry = true
        }
    }
    @IBAction func changePasswordTapped(_ sender: Any) {
        if oldPassword.text == ""{
            self.alert(message: "Please enter old password")
        }else if newPassword.text == ""{
            self.alert(message: "Please enter new password")
        }else if newPassword.text != changePassword.text{
            self.alert(message: "Password mismatch")
        }else{
            let model = ChangePassModel(oldPassword: oldPassword.text!, newPassword: oldPassword.text!)
            ApiManager.shared.changePass(model: model) { (issuccess) in
                if issuccess{
                    self.alert(message: "Password successfully changed")
                }else{
//                    self.alert(message: "Something went wrong", title: "Opps..")
                }
            }
        }
    }
}
