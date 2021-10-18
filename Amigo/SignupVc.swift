//
//  SignupVc.swift
//  Amigo
//
//  Created by Macbook on 14/10/21.
//

import UIKit

class SignupVc: UIViewController {

    @IBOutlet var viewCollection: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func login_tapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
