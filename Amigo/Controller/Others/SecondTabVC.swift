//
//  SecondTabVC.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit
import Koloda
import Alamofire
import MBProgressHUD
import AlamofireImage

class SecondTabVC: UIViewController {
   
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var swipeView: KolodaView!
    
    var userData = [AnyObject]()
    var toLikeUser = [String]()
    var id = UserDefaults.standard.value(forKey: "id") as! String
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeView.delegate = self
        swipeView.dataSource = self
        swipeView.layer.cornerRadius = 20
        
        getUserList()
        if UserDefaults.standard.value(forKey: "Gender") as! String == "male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
            self.backgroundImage.image = UIImage(named: "Background")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
            self.backgroundImage.image = UIImage(named: "backGirl")
        }
      
    }
    
//MARK: - APIs
    
    func getUserList(){
        if ReachabilityNetwork.isConnectedToNetwork(){
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let header : HTTPHeaders = ["x-access-token": token]
            AF.request(API.userList,method: .get,headers: header).responseJSON{ [self]
                response in
                switch(response.result){
                case .success(let json): do{
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    MBProgressHUD.hide(for: self.view, animated: true)
                    if status == 200{
                        print(respond)
                        toLikeUser.removeAll()
                        MBProgressHUD.hide(for: self.view, animated: true)
                        userData = respond.object(forKey: "data") as! [AnyObject]
                        if userData.count != 0{
                            for i in 0...userData.count-1{
                                toLikeUser += [userData[i]["id"] as! String]
                                MBProgressHUD.hide(for: self.view, animated: true)
                            }
                            print("sbkbsdfkbasbfasbfksabdf",toLikeUser)
                            swipeView.reloadData()
                        }else{
                            MBProgressHUD.hide(for: self.view, animated: true)
                            alert(message: "User exists 0")
                        }
                        
                        print("user to beliked", toLikeUser)
                        
                        self.view.isUserInteractionEnabled = true
                    }else{
                        MBProgressHUD.hide(for: self.view, animated: true)
                        alert(message: "\(status)")
                        self.view.isUserInteractionEnabled = true
                    }
                }
                case .failure(let error):
                    print(error)
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.view.isUserInteractionEnabled = true
                }
            }
        }else{
            MBProgressHUD.hide(for: self.view, animated: true)
            alert(message: "Please check internet connection")
        }
    }
//MARK:- BUTTONACTIONS
    
    @IBAction func dislikeBtn(_ sender: Any) {
        swipeView.swipe(.left)
        
        print("dislike")
    }
    @IBAction func refreshBtn(_ sender: Any) {
        print("refresh")
    }
    
    @IBAction func likeBtn(_ sender: Any) {
        swipeView.swipe(.right)
        print("like")
    }
    @IBAction func superLikeBtn(_ sender: Any) {
        swipeView.swipe(.up)
        
        print("Super")
    }
    
}

//MARK: - KOLODA VIEW DELEGATE
extension SecondTabVC: KolodaViewDelegate{
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection)
    {

        DispatchQueue.main.asyncAfter(deadline: .now()+10.0) { [self] in
            
            if direction == .left {
             
             }
             if direction == .right {
                MBProgressHUD.showAdded(to: self.view, animated: true)
                let likeuser = toLikeUser[index]
                print(toLikeUser)
                print(toLikeUser[index])
                print(index)
                let model = AddToFavModel(userId: id, toLikeUserId: likeuser)
                ApiManager.shared.favouriteApi(model: model) { (success) in
                    if success{
                        MBProgressHUD.hide(for: self.view, animated: true)
                        print("liked",id,likeuser)
                    }else{
                        MBProgressHUD.hide(for: self.view, animated: true)
                        print("liked",id,likeuser)
                        print("id not right")
                    }
                }
//
             }
            if direction == .up{
                MBProgressHUD.showAdded(to: self.view, animated: true)
                               let likeuser = toLikeUser[index]
                                let modelreq = AddReqModel(reqTo: likeuser, reqBy: id)
                                ApiManager.shared.requestApi(model: modelreq) { (issuccess) in
                                    if issuccess{
                                        MBProgressHUD.hide(for: self.view, animated: true)
                                        print("liked",id,likeuser)
                                    }else{
                                        MBProgressHUD.hide(for: self.view, animated: true)
                                        print("please check id",id,likeuser)
                                    }
                                }
            }
        }
      }
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right, .up]
    }

    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {

         let vc = self.storyboard!.instantiateViewController(
                                 withIdentifier: "SomeProfileVC") as! SomeProfileVC
        
               vc.id = userData[index]["id"] as! String
               self.navigationController?.pushViewController(vc, animated: true)
       
    }
}

//MARK: - KOLODA VIEW DATA SOURCE
extension SecondTabVC: KolodaViewDataSource{
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
         koloda.resetCurrentCardIndex()
        swipeView.reloadData()
        
       }

    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        
        return userData.count
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let overlay1 = (Bundle.main.loadNibNamed("slider", owner: self, options: nil)?[0] as! OverlayChild)
        overlay1.nameOutlet.text = userData[index]["name"] as? String ?? ""
        if let image = userData[index]["profileImageName"] as? String{
            let url = URL(string: image)
            if url != nil{
                overlay1.picOutlet.af.setImage(withURL: url!)
                print("image",url!)
            }else{
                overlay1.picOutlet.image = UIImage(named: "proimage")
                print("hello")
            }
        }
//        overlay1.picOutlet.image = UIImage(named: "Background")
        return overlay1
       
    }
}


