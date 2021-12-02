//
//  LikeVC.swift
//  Amigo
//
//  Created by mac on 19/11/2021.
//

import UIKit
import Alamofire

class RequestVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let requestId = ""
    @IBOutlet weak var likeTable: UITableView!{
        didSet{
            likeTable.tableFooterView = UIView(frame: .zero)
        }
    }
    let nameArray = ["Anika","Sherya","Lilly","Mona","Sonia"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
//          self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
    }
    
    @IBAction func deleteRequest(_ sender: UIButton) {
        
        ApiManager.shared.rejectReq(id: requestId) { (issuccess) in
            if issuccess{
                print("Hello Accepted")
                self.likeTable.reloadData()
                self.alert(message: "Hello Accepted")
            }else{
                print("completionFalse")
            }
        }
    }
    @IBAction func acceptRequest(_ sender: Any) {
        ApiManager.shared.approveReq(id: requestId) { (issuccess) in
            if issuccess{
                print("Hello Accepted")
                self.likeTable.reloadData()
                self.alert(message: "Hello Accepted")
            }else{
                print("completionFalse")
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likeTable.dequeueReusableCell(withIdentifier: "cell") as! RequestTableCell
        cell.cellName.text = nameArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "SomeProfileVC") as! SomeProfileVC
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }


}

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
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if status == 200{
                        let data = respond.object(forKey: "data") as! NSDictionary
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
