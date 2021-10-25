//
//  PersonalInformation1VC.swift
//  Amigo
//
//  Created by mac on 21/10/2021.
//

import UIKit

class PersonalInformation1VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalInformation2VC") as! PersonalInformation2VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
