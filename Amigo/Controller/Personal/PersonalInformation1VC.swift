//
//  PersonalInformation1VC.swift
//  Amigo
//
//  Created by mac on 21/10/2021.
//

import UIKit

class PersonalInformation1VC: UIViewController {

    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var nameOut: UITextField!
    @IBOutlet weak var emailOut: UITextField!
    @IBOutlet weak var phoneOut: UITextField!
    @IBOutlet weak var dobOut: UITextField!
    @IBOutlet weak var lookingFor: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        btnView.layer.cornerRadius = 20
        nameOut.layer.backgroundColor = UIColor.white.cgColor
        emailOut.layer.backgroundColor = UIColor.white.cgColor
        phoneOut.layer.backgroundColor = UIColor.white.cgColor
        dobOut.layer.backgroundColor = UIColor.white.cgColor
        
        
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalInformation2VC") as! PersonalInformation2VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func selectionBtn(_ sender: Any) {
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
