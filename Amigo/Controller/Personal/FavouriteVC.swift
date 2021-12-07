//
//  FavouriteVC.swift
//  Amigo
//
//  Created by mac on 19/11/2021.
//

import UIKit
import Alamofire
import MBProgressHUD


class FavouriteVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var favouriteTable: UITableView!{
        didSet{
            favouriteTable.tableFooterView = UIView(frame: .zero)
        }
    }
    
    var dataArray = [AnyObject]()
    var userUnlikeId = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
            //            self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favList()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteTable.dequeueReusableCell(withIdentifier: "cell") as! FavouriteTableCell
        cell.img.image = UIImage(named: "pic4")
        cell.nameText.text = dataArray[indexPath.row]["name"] as? String ?? ""
        cell.deleteBtn.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SomeProfileVC") as! SomeProfileVC
        vc.id = userUnlikeId[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func removeFav(_ sender: UIButton) {
        let alert = UIAlertController.init(title: "", message: "Are you sure?", preferredStyle: .alert)
        let yes = UIAlertAction.init(title: "Yes", style: .destructive) { (yes) in
            let userid = UserDefaults.standard.value(forKey: "id") as! String
            let userdeslike = self.userUnlikeId[sender.tag]
            print("useriddeslike",userdeslike)
            
            let model = RemoveFavModel(userId: userid, toUnLikeUserId: userdeslike)
            ApiManager.shared.removeFav(model: model) { [self] (issuccess) in
                
                if issuccess{
                    dataArray.remove(at: sender.tag)
                }else{
                    print("useriddeslike",userdeslike)
                    print("error please check")
                }
            }
        }
        let no = UIAlertAction.init(title: "no", style: .default, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        self.present(alert, animated: true, completion: nil)
    }
}

extension FavouriteVC{
    func favList(){
        if ReachabilityNetwork.isConnectedToNetwork(){
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let id = UserDefaults.standard.value(forKey: "id") as! String
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headerss : HTTPHeaders = ["x-access-token":token]
            AF.request(API.favList+id,method: .get,headers: headerss).responseJSON{ [self]
                response in
                switch(response.result){
                case .success(let json): do{
                    print("Json",json)
                    MBProgressHUD.hide(for: self.view, animated: true)
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if status == 200{
                        MBProgressHUD.hide(for: self.view, animated: true)
                        let data = respond.object(forKey: "data") as! [AnyObject]
                        dataArray = data
                        userUnlikeId.removeAll()
                        for i in 0...dataArray.count-1{
                            userUnlikeId.append(dataArray[i]["_id"] as! String)
                            print("userto delete",userUnlikeId)
                        }
                        
                        favouriteTable.reloadData()
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
