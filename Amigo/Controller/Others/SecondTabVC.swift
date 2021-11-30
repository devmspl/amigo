//
//  SecondTabVC.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit
import Koloda
import Alamofire

class SecondTabVC: UIViewController {
    
    

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var swipeView: KolodaView!
    @IBOutlet weak var picOut: UIImageView!
    
    var userData = [AnyObject]()
    var toLikeUser = [String]()
    var id = UserDefaults.standard.value(forKey: "id") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeView.delegate = self
        swipeView.dataSource = self
        swipeView.layer.cornerRadius = 20
        
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
            self.backgroundImage.image = UIImage(named: "Background")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
            self.backgroundImage.image = UIImage(named: "backGirl")
        }
       if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        getUserList()
        
    }
//MARK:- APIs
    
    func getUserList(){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let header : HTTPHeaders = ["x-access-token": token]
            AF.request(API.userList,method: .get,headers: header).responseJSON{ [self]
                response in
                switch(response.result){
                case .success(let json): do{
                    let status = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if status == 200{
                        print(respond)
                        userData = respond.object(forKey: "data") as! [AnyObject]
                        if userData.count != 0{
                            for i in 0...userData.count-1{
                                toLikeUser += [userData[i]["id"] as! String]
                            }
                        }else{
                            alert(message: "User exists 0")
                        }
                        
                        print("user to beliked", toLikeUser)
                        
                        self.view.isUserInteractionEnabled = true
                    }else{
                        alert(message: "\(status)")
                        self.view.isUserInteractionEnabled = true
                    }
                }
                case .failure(let error):
                    print(error)
                    self.view.isUserInteractionEnabled = true
                }
            }
        }else{
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

extension SecondTabVC: KolodaViewDelegate{
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection)
    {

        DispatchQueue.main.asyncAfter(deadline: .now()+10.0) { [self] in
            
            if direction == .left {
             
             }
             if direction == .right {
               let likeuser = toLikeUser[index]
                let modelreq = AddReqModel(reqTo: likeuser, reqBy: id)
                ApiManager.shared.requestApi(model: modelreq) { (issuccess) in
                    if issuccess{
                        toLikeUser.remove(at: 0)
                        koloda.reloadData()
                        print("liked",id,likeuser)
                    }else{
                        print("please check id",id,likeuser)
                    }
                }
             }
            if direction == .up{
                let likeuser = toLikeUser[index]
                let model = AddToFavModel(userId: id, toLikeUserId: likeuser)
                ApiManager.shared.favouriteApi(model: model) { (success) in
                    if success{
                        toLikeUser.remove(at: 0)
                        koloda.reloadData()
                        print("liked",id,likeuser)
                    }else{
                        print("liked",id,likeuser)
                        print("id not right")
                    }
                }
            }
            if direction == .down{
                
            }
            
        }
      }
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right, .up, .down]
    }

    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {

         let vc = self.storyboard!.instantiateViewController(
                                 withIdentifier: "SomeProfileVC") as! SomeProfileVC
        
//               vc.Propertyid = HomelistArray[index]["_id"] as! String
               self.navigationController?.pushViewController(vc, animated: true)
       
    }
}
extension SecondTabVC: KolodaViewDataSource{
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
         koloda.resetCurrentCardIndex()
           koloda.reloadData()
        
       }

    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        
        return userData.count
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let overlay1 = (Bundle.main.loadNibNamed("slider", owner: self, options: nil)?[0] as! OverlayChild)
//        koloda.reloadData()
        return overlay1
       
    }
}
