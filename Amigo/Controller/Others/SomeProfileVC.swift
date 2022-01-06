//
//  SomeProfileVC.swift
//  Amigo
//
//  Created by mac on 29/10/2021.
//

import UIKit
import Alamofire
import MBProgressHUD
import AlamofireImage

class SomeProfileVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var proImage: UIImageView!

    @IBOutlet weak var dislike: UIButton!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var star: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var work: UILabel!
    @IBOutlet weak var upperCollection: UICollectionView!
    
    var key = ""
    var id = ""
    var gallery = [AnyObject]()
    
    
    let label = ["Interest1","Interest2","Interest3","Interest4","Interest5","Interest6","Interest7","Interest8"]
    let image = [UIImage(named: "pic4"),UIImage(named: "pic4"),UIImage(named: "pic4"),UIImage(named: "pic4")]
    let image2 = [UIImage(named: "pic4"),UIImage(named: "pic4"),UIImage(named: "pic4"),UIImage(named: "pic4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
     print(id)
        getSomeProfile()
        if UserDefaults.standard.value(forKey: "Gender") as! String == "male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")

        }
    }
    override func viewWillAppear(_ animated: Bool) {
        getSomeProfile()
    }
    
    @IBAction func likeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CongratulationVC") as! CongratulationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func starTapped(_ sender: Any) {
    }
    @IBAction func dislikeTapped(_ sender: Any) {
        alert(message: "Dislike Successful")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(gallery.count)
            return gallery.count
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = upperCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UpperCollectionCell
        
        if let image = gallery[indexPath.row]["image"] as? String{
            let url = URL(string: image)
            if url != nil{
                cell.imageupper.af.setImage(withURL: url!)
            }
            else{
                print("Empty url please check")
            }
        }
            return cell
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: upperCollection.frame.width/1.5, height: upperCollection.frame.height)
        
        
    } 
    
    @IBAction func optionBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProUserVC") as! ProUserVC
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


class UpperCollectionCell: UICollectionViewCell{
    @IBOutlet weak var imageupper: UIImageView!
    override func awakeFromNib() {
        imageupper.layer.cornerRadius = 20
    }
}
class LowerCollectionCell: UICollectionViewCell{
    @IBOutlet weak var viewInterest: UIView!
    @IBOutlet weak var labelout: UILabel!
    
    override func awakeFromNib() {
        viewInterest.layer.cornerRadius = 10
        viewInterest.layer.backgroundColor = UIColor.gray.cgColor
    }
}

class PicCollectionCell: UICollectionViewCell{
    
    @IBOutlet weak var viewPic: UIView!
    @IBOutlet weak var imageOut
        : UIImageView!
}

//MARK: - extension profile api
extension SomeProfileVC{
    func getSomeProfile(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if ReachabilityNetwork.isConnectedToNetwork(){
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
                        name.text = data.object(forKey: "name") as? String ?? "---"
                        about.text = data.object(forKey: "aboutMe") as? String ?? "---"
                        work.text = data.object(forKey: "myWork") as? String ?? "---"
                        gallery = data.object(forKey: "gallery") as! [AnyObject]
                        
                        if let image = data.object(forKey: "profileImageName") as? String{
                            let url = URL(string: image)
                            if url! != nil{
                                DispatchQueue.main.async {
                                    proImage.af.setImage(withURL: url!)
                                    print("bcsbvadbvdbvdsfvbdkjbvkdjsfbvkjdsfbvkjdsbfvjkdsfbvkjsb",url!)
                                    print("bjhdshv")
                                }
                                
                            }else{
                                if let imagew = gallery[0]["image"] as? String{
                                    let urrl = URL(string: imagew)
                                    if url != nil{
                                        proImage.af.setImage(withURL: urrl!)
                                        print("bcsbvadbvdbvdsfvbdkjbvkdjsfbvkjdsfbvkjdsbfvjkdsfbvkjsb",urrl!)
                                        print("bjhdshv")
                                    }else{
                                        proImage.image = UIImage(named: "proimage")
                                    }
                                }
                            }
                        }
                        print(gallery.count,"sdcasdcjsahdbcjhsbadchjbsd")
                        print("success=====",respond)
                        upperCollection.reloadData()
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
