//
//  LikeVC.swift
//  Amigo
//
//  Created by mac on 19/11/2021.
//

import UIKit
import Alamofire
import MBProgressHUD

class RequestVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var requestId = [String]()
    @IBOutlet weak var likeTable: UITableView!{
        didSet{
            likeTable.tableFooterView = UIView(frame: .zero)
        }
    }
    var dataArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
//          self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestList()
    }
    
    @IBAction func deleteRequest(_ sender: UIButton) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let requestid = requestId[sender.tag]
        print("request id",requestid)
        ApiManager.shared.rejectReq(id: requestid) { (issuccess) in
            if issuccess{
                MBProgressHUD.hide(for: self.view, animated: true)
                print("Hello Accepted")
                self.likeTable.reloadData()
                self.alert(message: "Hello Accepted")
            }else{
                MBProgressHUD.hide(for: self.view, animated: true)
                print("completionFalse")
            }
        }
    }
    @IBAction func acceptRequest(_ sender: UIButton) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let requestid = requestId[sender.tag]
        print("request approve id",requestid)
        ApiManager.shared.approveReq(id: requestid) { (issuccess) in
            if issuccess{
                MBProgressHUD.hide(for: self.view, animated: true)
                print("Hello Accepted")
                self.likeTable.reloadData()
                self.alert(message: "Hello Accepted")
            }else{
                MBProgressHUD.hide(for: self.view, animated: true)
                print("completionFalse")
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likeTable.dequeueReusableCell(withIdentifier: "cell") as! RequestTableCell
       let reqBy = dataArray[indexPath.row]["reqBy"] as! NSDictionary
        cell.cellName.text = reqBy.object(forKey: "name") as? String ?? ""
        cell.acceptBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SomeProfileVC") as! SomeProfileVC
        let reqBy = dataArray[indexPath.row]["reqBy"] as! NSDictionary
        vc.id = reqBy.object(forKey: "_id") as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }


}

//MARK: - REQUEST LIST API
extension RequestVC{
    func requestList(){
        if ReachabilityNetwork.isConnectedToNetwork(){
            
            let id = UserDefaults.standard.value(forKey: "id") as! String
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headerss : HTTPHeaders = ["x-access-token":token]
            AF.request(API.requestList+id,method: .get,headers: headerss).responseJSON{ [self]
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
                        for i in 0...dataArray.count-1{
                            let reqBy = dataArray[i]["reqBy"] as! NSDictionary
                            requestId.append(reqBy.object(forKey: "reqBy") as! String)
                        }
                        likeTable.reloadData()
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
