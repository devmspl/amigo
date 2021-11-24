//
//  PersonalInformation1VC.swift
//  Amigo
//
//  Created by mac on 21/10/2021.
//

import UIKit

class PersonalInformation1VC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var nameOut: UITextField!
    @IBOutlet weak var emailOut: UITextField!
    @IBOutlet weak var phoneOut: UITextField!
    @IBOutlet weak var dobOut: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        dobOut.delegate = self
        
        btnView.layer.cornerRadius = 20
        nameOut.layer.backgroundColor = UIColor.white.cgColor
        emailOut.layer.backgroundColor = UIColor.white.cgColor
        phoneOut.layer.backgroundColor = UIColor.white.cgColor
        dobOut.layer.backgroundColor = UIColor.white.cgColor
        
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker(textField: dobOut)
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


extension PersonalInformation1VC{
    func datePicker(textField : UITextField){
        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        datepicker.preferredDatePickerStyle = .wheels
        textField.inputView = datepicker
        let dateMinimum = "11/30/2003"
        let dateformatter  = DateFormatter()
        dateformatter.dateStyle = .short
        datepicker.maximumDate = dateformatter.date(from: dateMinimum)
//        datepicker.maximumDate = 11/12/2003
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cnclBtnclick))
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBtnclick))
        
        let flexiblebtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelBtn,flexiblebtn,doneBtn], animated: false)
        textField.inputAccessoryView = toolbar
          
}
   @objc func cnclBtnclick(){
        dobOut.resignFirstResponder()
       
    }
    
   @objc func doneBtnclick(){
    if let datePicker = dobOut.inputView as? UIDatePicker{
        let dateformatter  = DateFormatter()
        dateformatter.dateStyle = .short
        dobOut.text = dateformatter.string(from: datePicker.date)
        dobOut.resignFirstResponder()
//        dobOut.text = datePicker.date
    }
        
}
}
