//
//  ProfileVC.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit
import Alamofire
import MBProgressHUD
import Photos
import BSImagePicker
import AlamofireImage

class ProfileVC: BaseClass{

    
    @IBOutlet weak var seprator: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var livingIn: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var email: UITextField!
    
    var urlImg = String()
    var nameSet = ""
    var emailSet = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewImage.layer.cornerRadius = 65
        profileImage.layer.cornerRadius = 65
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
        vc.image = urlImg
        vc.name = nameSet
        vc.email = emailSet
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func imageChange(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.profileImage.image = image
            upload(
                image: self.profileImage.image!,
                        progressCompletion: { [weak self] percent in
                           guard let _ = self else {
                             return
                           }
                           print("Status: \(percent)")
                          if percent == 1.0{
                         self!.alert(message: "Profile updated Successfully", title: "Image")
                               
                           }
                         },
                         completion: { [weak self] result in
                           guard let _ = self else {
                             return
                           }
                       })
        } failure: { Error in
            print(Error)
        }
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
                        
                        nameSet = data.object(forKey: "name") as? String ?? ""
                        emailSet = data.object(forKey: "email") as? String ?? ""
                        
                        livingIn.text = data.object(forKey: "livingIn") as? String ?? ""
                        if let image = data.object(forKey: "profileImageName") as? String{
                           
                            let url = URL(string: image ?? "")
                            if url != nil{
                                 urlImg = image
                                self.profileImage.af.setImage(withURL: url!)
                               
                                print("hello")
                            }else{
                                self.profileImage.image = UIImage(named: "proimage")
                            }
                        }
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

//MARK: - UPLOAD PROFILE IMAGE
extension ProfileVC{
    func upload(image: UIImage,
                      progressCompletion: @escaping (_ percent: Float) -> Void,
                      completion: @escaping (_ result: Bool) -> Void) {
              guard let imageData = image.jpegData(compressionQuality: 0.5) else {
              print("Could not get JPEG representation of UIImage")
              return
            }
            let randomno = Int.random(in: 1000...100000)
            let imgFileName = "image\(randomno).jpg"
//        let parameterS: Parameters = ["id": "\(UserDefaults.standard.value(forKey: "userid")!)"]
        let userId = UserDefaults.standard.value(forKey: "id") as! String
            AF.upload(
              multipartFormData: { multipartFormData in
//                for (key, value) in parameterS {
//                if let temp = value as? String {
//                multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//                }
//                }
                multipartFormData.append(imageData,
                                         withName: "file",
                                         fileName: imgFileName,
                                         mimeType: "image/jpeg")
              },
              to: API.profileImage+userId, usingThreshold: UInt64.init(), method: .put)
              .uploadProgress { progress in
                   progressCompletion(Float(progress.fractionCompleted))
              }
              .response { response in
                  debugPrint(response)
              }
          }
}
