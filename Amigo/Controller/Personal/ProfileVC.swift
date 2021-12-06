//
//  ProfileVC.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit
import Alamofire
import MBProgressHUD

class ProfileVC: UIViewController,UIImagePickerControllerDelegate{

    @IBOutlet weak var seprator: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var livingIn: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
            seprator.isHidden = false
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
            seprator.isHidden = true
//            self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        getProfile()
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//    }
    @IBAction func settingTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func imageChange(_ sender: Any) {
    }
    
}

//MARK: - EXTENSION
extension ProfileVC{
    func getProfile(){
        if ReachabilityNetwork.isConnectedToNetwork(){
            MBProgressHUD.showAdded(to: self.view, animated: true)
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
                        email.text = data.object(forKey: "email") as? String ?? ""
                        name.text = data.object(forKey: "name") as? String ?? ""
                        about.text = data.object(forKey: "aboutMe") as? String ?? ""
                        nameLabel.text = name.text
                        livingIn.text = data.object(forKey: "livingIn") as? String ?? ""
                        print("success=====",respond)
                        
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
