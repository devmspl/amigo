//
//  PersonalInformation1VC.swift
//  Amigo
//
//  Created by mac on 21/10/2021.
//

import UIKit
import Alamofire
import MBProgressHUD

class PersonalInformation1VC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var nameOut: UITextField!
    @IBOutlet weak var lookingFor: UITextField!
    @IBOutlet weak var phoneOut: UITextField!
    @IBOutlet weak var dobOut: UITextField!

    var key  = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if key == "U"{
            getProfileDetails()
        }else{
            print("Gender screen")
        }
        dobOut.delegate = self
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
            self.btnView.backgroundColor = UIColor(named: "girlButton")
        }
        
        btnView.layer.cornerRadius = 20
        nameOut.layer.backgroundColor = UIColor.white.cgColor
        lookingFor.layer.backgroundColor = UIColor.white.cgColor
        phoneOut.layer.backgroundColor = UIColor.white.cgColor
        dobOut.layer.backgroundColor = UIColor.white.cgColor
        
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker(textField: dobOut)
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        if nameOut.text == ""{
            alert(message: "Please enter name")
        }else if lookingFor.text == ""{
            alert(message: "Please enter your interest")
        }
        else if phoneOut.text == ""{
            alert(message: "Please enter phone")
        }else if dobOut.text == ""{
            alert(message: "Please enter dob")
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalInformation2VC") as! PersonalInformation2VC
            vc.name = nameOut.text!
            vc.lookingFor = lookingFor.text!
            vc.phone = phoneOut.text!
            vc.dob = dobOut.text!
            vc.key = key
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
        let dateminimum = "11/30/2003"
        let dateformetter = DateFormatter()
        dateformetter.dateStyle = .medium
        datepicker.maximumDate = dateformetter.date(from: dateminimum)
    
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
        dateformatter.dateFormat = "dd-MM-YYYY"
        dobOut.text = dateformatter.string(from: datePicker.date)
        dobOut.resignFirstResponder()
//        dobOut.text = datePicker.date
    }
        
}
}


extension PersonalInformation1VC{
    func getProfileDetails(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if ReachabilityNetwork.isConnectedToNetwork(){
            let id = UserDefaults.standard.value(forKey: "id") as! String
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headerss : HTTPHeaders = ["x-access-token":token]
            AF.request(API.getUser+id,method: .get,headers: headerss).responseJSON{ [self]
                response in
                switch(response.result){
                case .success(let json): do{
                    print("Json",json)
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if status == 200{
                        MBProgressHUD.hide(for: self.view, animated: true)
                     let data = respond.object(forKey: "data") as! NSDictionary
                        nameOut.text = data.object(forKey: "name") as? String ?? ""
                        lookingFor.text = data.object(forKey: "lookingFor") as? String ?? ""
                        dobOut.text = data.object(forKey: "dob") as? String ?? ""
                        phoneOut.text = data.object(forKey: "phoneNo") as? String ?? ""
                    }else{
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.alert(message: "error")
                    }
                }
                case .failure(let error):do{
                    MBProgressHUD.hide(for: self.view, animated: true)
                    print("error",error)
                    self.view.isUserInteractionEnabled = true
                }
                }
            }
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
            self.alert(message: "Please check internet connection")
        }
    }
}
