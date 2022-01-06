//
//  PersonalInformation2VC.swift
//  Amigo
//
//  Created by mac on 21/10/2021.
//

import UIKit
import DropDown
//import ImagePicker
import Photos
import BSImagePicker
import MBProgressHUD
import Alamofire
import OpalImagePicker
import Toast
import MBProgressHUD

class PersonalInformation2VC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, OpalImagePickerControllerDelegate{

    @IBOutlet var imageCollection: UICollectionView!
    @IBOutlet var textViews: [UIView]!
    @IBOutlet weak var aboutMe: UITextField!
    @IBOutlet weak var myWork: UITextField!
    @IBOutlet weak var education: UITextField!
    @IBOutlet weak var selectCity: UIButton!
    @IBOutlet weak var selectCityText: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var favouriteSport: UITextField!
    @IBOutlet weak var eduDegree: UITextField!
    @IBOutlet weak var continueView: UIView!
    
    let drop = DropDown()
    var name = ""
    var lookingFor = ""
    var phone = ""
    var dob = ""
    var imagee = [UIImage(named: "addicon"),UIImage(named: "addicon"),UIImage(named: "addicon"),UIImage(named: "addicon"),UIImage(named: "addicon"),UIImage(named: "addicon")]
    var gallery = [AnyObject]()
    
    var myimage: [Data] = [Data]()
    var selectedAsset = [PHAsset]()
    var img = [UIImage]()
    let imageVC = OpalImagePickerController()
    let configuration = OpalImagePickerConfiguration()
    var key = ""

//MARK:- VIEWDID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        if key == "U"{
            getProfileDetails()
        }else{
            print("enter details")
        }
      
        continueView.layer.cornerRadius = 20
        
        imageVC.imagePickerDelegate = self
        imageVC.maximumSelectionsAllowed = 6
        
        imageVC.allowedMediaTypes = Set([PHAssetMediaType.image])
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You can select that only six images!", comment: "")
        imageVC.configuration = configuration
        print(name);print(lookingFor);print(phone);print(dob)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageCollection.collectionViewLayout = layout
        imageCollection.backgroundColor = .white
        
        let gesture = UILongPressGestureRecognizer(target: self, action:  #selector(gestureRecognizer))
        imageCollection.addGestureRecognizer(gesture)
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
            self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
    }

//MARK: - COVERT ASSETS TO IMAGE
    func convertAssestToImage(assets: [PHAsset]){
        self.img.removeAll()
        self.myimage.removeAll()

        for i in 0..<assets.count {

                    let manager = PHImageManager.default()
                    let option = PHImageRequestOptions()
                    var thumbnail = UIImage()
                    option.isSynchronous = true
                    manager.requestImage(for: selectedAsset[i],targetSize: CGSize(width: 200, height: 200), contentMode: PHImageContentMode.aspectFill, options: option, resultHandler: { (result, info) -> Void in
                        thumbnail = result!
                    })

                    let data = thumbnail.jpegData(compressionQuality: 0.7)
                    let newImage = UIImage(data: data!)
                    self.img.append(newImage! as UIImage)
                    self.myimage.append(data!)

                    }

                    DispatchQueue.main.async {
                      self.imageCollection.reloadData()
                    }
        
            }
    

//MARK: - GESTURE METHOD
    @objc func gestureRecognizer( _ gesture: UILongPressGestureRecognizer){
        guard let collectionView = imageCollection else{
            return
        }
        switch gesture.state{
        case .began:
            guard  let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
            
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

//MARK: - BUTTON ACTION
   
    @IBAction func selectCityBtn(_ sender: Any) {
        drop.anchorView = selectCityText
        drop.dataSource = ["Chandigarh","Mohali"]
        drop.show()
        drop.selectionAction = { [unowned self] (index: Int,Item: String) in
            selectCityText.text = Item
        }
        print("fdfgshdf")
    }
    @IBAction func continueTapped(_ sender: Any) {
        
               
      if education.text == "" || aboutMe.text == "" || selectCityText.text == "" || height.text == "" || weight.text == "" || favouriteSport.text == "" || eduDegree.text == "" || myWork.text == "" {
           
        alert(message: "Please enter all fields")
        
        }else{
            let sex =  UserDefaults.standard.value(forKey: "Gender") as! String
            let modelLoc = loction(type: "hello", cordinates: [2.2,2.323])
            let model = UpdateUser(name: name, phoneNo: phone, dob: dob, school: education.text!, aboutMe: aboutMe.text!, livingIn: selectCityText.text!, height: height.text!, weight: weight.text!, favSports: favouriteSport.text!, degreeOfEducation: eduDegree.text!, lookingFor: lookingFor, myWork: myWork.text!,
                                   sex: sex,loc: modelLoc)
            print(model)
            ApiManager.shared.update(model: model) { [self] (isSuccess) in
                if isSuccess{
        MBProgressHUD.hide(for: self.view, animated: true)
                    upload(
                        image: img,
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
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    print("hello")
                }else{
        MBProgressHUD.hide(for: self.view, animated: true)
                    print("Failure")
                }
            }
        }
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - extension
extension PersonalInformation2VC{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if key == "U"{
            return gallery.count
        }else{
            if img.count != 0{
                return img.count
            }else{
                return imagee.count
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InformationCell
        if key == "U"{
            if let image = gallery[indexPath.item]["image"] as? String{
                let url = URL(string: image)
                cell.picSelected.af.setImage(withURL: url!)
            }else{
                self.alert(message: "")
            }
        }else{
            if img.count == 0{
                cell.picSelected.image = imagee[indexPath.item]
            }
            else{
                cell.picSelected.image = img[indexPath.item]
            }
        }
       
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//       hello()
        
        present(imageVC, animated: true, completion: nil)
        
        
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]){
        if assets.count < 6{
//            picker.view.
//            picker.view.makeToast("Please select 6 images", duration: 3.0, position: CSToastPositionTop)
            
            picker.alert(message: "Please Select 6 images")
           
        }else {
            selectedAsset.append(contentsOf: assets)
            convertAssestToImage(assets: assets)
            imageCollection.reloadData()
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollection.frame.width/3.6, height: imageCollection.frame.height/2.1)
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if img.count == 0{
            print("Select")
        }else{
            let item = img.remove(at: sourceIndexPath.row)
            img.insert(item, at: destinationIndexPath.row)
        }
        
    }
}

// MARK: - IMAGE UPLOAD API
extension PersonalInformation2VC{
    func upload(image: [UIImage],
                      progressCompletion: @escaping (_ percent: Float) -> Void,
                      completion: @escaping (_ result: Bool) -> Void) {
//              guard let imageData = image.jpegData(compressionQuality: 0.5) else {
//              print("Could not get JPEG representation of UIImage")
//              return
//            }`
       
            let randomno = Int.random(in: 1000...100000)
           let imgFileName = "image\(randomno).jpg"
        
            
//        let parameterS: Parameters = ["id": "\(UserDefaults.standard.value(forKey: "userid")!)"]
        let userId = UserDefaults.standard.value(forKey: "id") as! String
            AF.upload(
              multipartFormData: { multipartFormData in
                  if image.count != 0{
                      for i in 0...image.count-1{
                                          
                          multipartFormData.append(image[i].jpegData(compressionQuality: 0.8)!,
                                                   withName: "files[]",
                                                   fileName: imgFileName,
                                                   mimeType: "image/jpeg")
                                     
                                    }
                  }else {
                      self.alert(message: "please select images")
                  }
                
                         
//                for (key, value) in parameterS {
//                if let temp = value as? String {
//                multipartFormData.append(temp.data(using: .utf8)!, withName: key)
//                }
//                }
//                multipartFormData.append(imageData,
//                                         withName: "file",
//                                         fileName: imgFileName,
//                                         mimeType: "image/jpeg")
//                multipartFormData = image
              },
                to: API.multiImage+userId, usingThreshold: UInt64.init(), method: .put)
              .uploadProgress { progress in
                   progressCompletion(Float(progress.fractionCompleted))
              }
              .response { response in
                  debugPrint(response)
              }
          }
}

// MARK: - EXTENSION FOR API

extension PersonalInformation2VC{
    func getProfileDetails(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        if ReachabilityNetwork.isConnectedToNetwork(){
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
                        aboutMe.text = data.object(forKey: "aboutMe") as? String ?? ""
                        myWork.text = data.object(forKey: "myWork") as? String ?? ""
                        education.text = data.object(forKey: "school") as? String ?? ""
                        selectCityText.text = data.object(forKey: "livingIn") as? String ?? ""
                 
                        height.text = data.object(forKey: "height") as? String ?? ""
                        weight.text = data.object(forKey: "weight") as? String ?? ""
                        favouriteSport.text = data.object(forKey: "favSports") as? String ?? ""
                        eduDegree.text = data.object(forKey: "degreeOfEduction") as? String ?? ""
                        if let newgallery = data.object(forKey: "gallery") as? [AnyObject]{
                            gallery = newgallery
                        }
                        print(gallery.count,"sdcasdcjsahdbcjhsbadchjbsd")
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
