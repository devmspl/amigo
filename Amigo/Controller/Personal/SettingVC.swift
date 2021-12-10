//
//  SettingVC.swift
//  Amigo
//
//  Created by mac on 25/11/2021.
//

import UIKit

class SettingVC: UIViewController {

    
    @IBOutlet weak var nameOut: UILabel!
    @IBOutlet weak var emailOut: UILabel!
    @IBOutlet weak var imagePro: UIImageView!
    @IBOutlet weak var settingTable: UITableView!{
        didSet{
            settingTable.tableFooterView = UIView(frame: .zero)
        }
    }
    var name = ""
    var email = ""
    var image = ""
    
    let setarray = ["Terms and conditions","Privacy policy","Support","Edit profile","Change password","Sign out"]
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
//            seprator.isHidden = false
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
//            seprator.isHidden = true
//            self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

class SettingCell: UITableViewCell{
    
    @IBOutlet weak var setCategory: UILabel!
}

extension SettingVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTable.dequeueReusableCell(withIdentifier: "cell") as! SettingCell
        cell.setCategory.text = setarray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePassword") as! ChangePassword
        
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 5{
            let alert = UIAlertController.init(title: "Sign out", message: "Do you want to sign out?", preferredStyle: .alert)
           
            let ok = UIAlertAction.init(title: "Yes", style: .destructive) { (ok) in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                UserDefaults.standard.removeObject(forKey: "id")
                print("sign")
                UserDefaults.standard.removeObject(forKey: "token")
                UserDefaults.standard.removeObject(forKey: "Gender")
//                let nav = UINavigationController(rootViewController: vc)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            alert.addAction(ok)
            alert.addAction(UIAlertAction.init(title: "no", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
           
            
        }
    }
    
    
    
}
