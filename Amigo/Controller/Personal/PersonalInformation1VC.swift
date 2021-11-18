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


    override func viewDidLoad() {
        super.viewDidLoad()

        btnView.layer.cornerRadius = 20
        nameOut.layer.backgroundColor = UIColor.white.cgColor
        emailOut.layer.backgroundColor = UIColor.white.cgColor
        phoneOut.layer.backgroundColor = UIColor.white.cgColor
        dobOut.layer.backgroundColor = UIColor.white.cgColor
        
        
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        if nameOut.text == ""{
            alert(message: "Please enter name")
        }else if emailOut.text == ""{
            alert(message: "Please enter email")
        }
        else if phoneOut.text == ""{
            alert(message: "Please enter phone")
        }else if dobOut.text == ""{
            alert(message: "Please enter dob")
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalInformation2VC") as! PersonalInformation2VC
            vc.name = nameOut.text!
            vc.email = emailOut.text!
            vc.phone = phoneOut.text!
            vc.dob = dobOut.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
   
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
