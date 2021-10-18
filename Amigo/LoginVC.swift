//
//  LoginVC.swift
//  Amigo
//
//  Created by Macbook on 14/10/21.
//

import UIKit

class LoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgot_pass(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPassVC") as! ForgotPassVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func back_btn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
