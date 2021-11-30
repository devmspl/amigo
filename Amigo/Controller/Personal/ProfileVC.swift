//
//  ProfileVC.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit
import Alamofire

class ProfileVC: UIViewController {

    @IBOutlet weak var seprator: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var name: UITextField!
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
    
    @IBAction func settingTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func imageChange(_ sender: Any) {
    }
    
}

extension ProfileVC{
    func getProfile(){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let id = UserDefaults.standard.value(forKey: "id") as! String
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headerss : HTTPHeaders = ["x-access-token":token]
            AF.request(API.getUser+id,method: .get,headers: headerss).responseJSON{
                response in
                switch(response.result){
                case .success(let json): do{
                    print("Json",json)
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if status == 200{
                        print("success=====",respond)
                    }else{
                        self.alert(message: "error")
                    }
                }
                case .failure(let error):do{
                    print("error",error)
                    self.view.isUserInteractionEnabled = true
                }
                }
            }
        }else{
            self.alert(message: "Please check internet connection")
        }
    }
}
