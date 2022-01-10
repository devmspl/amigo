//
//  FirstTabVC.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit
import Alamofire
import AlamofireImage
import MBProgressHUD

class FirstTabVC: UIViewController {
   
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var messagetable: UITableView!
    @IBOutlet weak var newMatchColloction: UICollectionView!
    @IBOutlet weak var noMatch: UILabel!
    
    let imgCollection = [AnyObject]()
    let collName = ["Anita","Reshma","Roma","Yami","Priti","Test"]
    let imgTable = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "8")]
    let tableName = ["Anika","Sherya","Lilly","Mona","Sonia","Monika","Katrina","Kiran"]
    let message = ["Hello","hii","How are you","Where you  live?","lets meet on coffee","Yes offcource","No we can't","Let's do this"]
    var conversationId = ""
    var dataArray = [AnyObject]()
    var tableData = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getConversionApi()
        GetNewMatchApi()
        coversationListApi()
        backView.backgroundColor = UIColor.clear
        socket.disconnect()
       
    }
}


class MessageTable: UITableViewCell{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageTable: UIImageView!
    @IBOutlet weak var msgDot: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageCount: UILabel!
    override func awakeFromNib() {
        print("hello")
    }
}

class NewCollection: UICollectionViewCell{
    @IBOutlet weak var dotImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgColl: UIImageView!
    override  func awakeFromNib() {
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            dotImage.image = UIImage(named: "dot")
            
        }else{
            dotImage.image = UIImage(named: "pinkNewMatch")
        }
    }
}


// MARK: - EXTENSION table collection

extension FirstTabVC: UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagetable.dequeueReusableCell(withIdentifier: "cell") as! MessageTable
        cell.nameLabel.text = tableData[indexPath.row]["name"] as? String ?? ""
        cell.messageLabel.text = tableData[indexPath.row]["lastMsg"] as? String ?? ""
        if UserDefaults.standard.value(forKey: "Gender") as! String == "male"{
            cell.msgDot.image = UIImage(named: "msgDot")
        }else{
            cell.msgDot.image = UIImage(named: "pinkDot")
        }
        if let image = tableData[indexPath.row]["profileImageName"] as? String{
            let url = URL(string: image)
            if url != nil{
                cell.imageTable.af.setImage(withURL: url!)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ChatVC") as! ChatVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newMatchColloction.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewCollection
        let status = dataArray[indexPath.row]["status"] as? String ?? ""
        
        if status == "active"{
            cell.dotImage.image = UIImage(named: "greenDot")
        }
     
        if let image = dataArray[indexPath.item]["profileImageName"] as? String{
            let url = URL(string: image)
            if url != nil{
                print(url!)
                cell.imgColl.af.setImage(withURL: url!)
            }
        }
        cell.nameLabel.text = dataArray[indexPath.item]["name"] as? String ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ChatVC") as! ChatVC
        let idUser = dataArray[indexPath.item]["id"] as! String
        vc.sendTo = idUser
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: newMatchColloction.frame.width/4.5, height: newMatchColloction.frame.height/0.5)
    }
    
}

//MARK: - GET CONVERSATION API
extension FirstTabVC{
    func getConversionApi(){
        if ReachabilityNetwork.isConnectedToNetwork(){
            MBProgressHUD.showAdded(to: self.view, animated: true)
            AF.request(API.conversation+conversationId, method: .get,encoding: JSONEncoding.default).responseJSON{
                response in
                switch (response.result){
                case .success(let json):do{
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    MBProgressHUD.hide(for: self.view, animated: true)
                    if status == 200{
                        MBProgressHUD.hide(for: self.view, animated: true)
                        print(respond)
                        self.messagetable.reloadData()
                    }else{
                        MBProgressHUD.hide(for: self.view, animated: true)
                        print("hello")
                    }
                }case .failure(let error):do{
                    MBProgressHUD.hide(for: self.view, animated: true)
                    print(error,"errorfsdfsd")
                    self.alert(message: "Status not 200")
                }
                }
            }
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
            self.alert(message: "Please check iternet connection")
        }
    }
}

//MARK: - NEW MATCH API

extension FirstTabVC{
    func GetNewMatchApi(){
        if ReachabilityNetwork.isConnectedToNetwork(){
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let id = UserDefaults.standard.value(forKey: "id") as! String
            let head : HTTPHeaders = ["x-access-token":token]
            AF.request(API.newMatchList+id,method: .get,headers: head).responseJSON{ [self]
                response in
                switch (response.result){
                case .success(let json):do{
                    let statusCode = response.response?.statusCode
                    let respond = json as! NSDictionary
                    let message = respond.object(forKey: "message") as! String
                    MBProgressHUD.hide(for: self.view, animated: true)
                    if statusCode == 200{
                        MBProgressHUD.hide(for: self.view, animated: true)
                        dataArray.removeAll()
//                        print("Success======",respond)
                        dataArray = respond.object(forKey: "data") as! [AnyObject]
                        print("dataArray",dataArray,dataArray.count)
                        if dataArray.count == 0{
                            noMatch.isHidden = false
                         
                        }else{
                            noMatch.isHidden = true
                        }
                        newMatchColloction.reloadData()
                        print("Success",message)
                    }else{
                        MBProgressHUD.hide(for: self.view, animated: true)
                        print("fail",respond)
                    }
                }
    
                case .failure(let error): do{
                    print("error",error)
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                }
        }
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
            self.alert(message: "Please check internet connection")
        }
}
}

//MARK: - CONVERSATION LIST

extension FirstTabVC{
    func coversationListApi(){
        if ReachabilityNetwork.isConnectedToNetwork(){
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let id = UserDefaults.standard.value(forKey: "id") as! String
            AF.request(API.conversationList+id,method: .get,encoding: JSONEncoding.default).responseJSON{ [self]
                response in
                print(API.conversationList+id)
                switch(response.result){
                case .success(let json): do{
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if status == 200{
                        print("hsgdjhsauasf",respond)
                        let data = respond.object(forKey: "data") as! [AnyObject]
                        tableData = data
                        messagetable.reloadData()
                        print("sdhjhsadjshadv",tableData.count)
                        print("abdvjdjhvhve")
                      
                    }else{
                        print("error")
                    }
                }
                case .failure(let error):do{
                    print("error",error)
                }
                }
            }
            
        }else{
            alert(message: "Please check internet connection")
        }
    }
}
