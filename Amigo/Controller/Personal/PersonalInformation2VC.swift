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

class PersonalInformation2VC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate{

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
    @IBOutlet weak var lookingFor: UITextField!
    @IBOutlet weak var eduDegree: UITextField!
    @IBOutlet weak var continueView: UIView!
    
    let drop = DropDown()
    var name = ""
    var email = ""
    var phone = ""
    var dob = ""
    var imagee = [UIImage(named: "addicon"),UIImage(named: "addicon"),UIImage(named: "addicon"),UIImage(named: "addicon"),UIImage(named: "addicon"),UIImage(named: "addicon")]
//    let config = Configuration()
  
   
    var myimage: [Data] = [Data]()
    var selectedAsset = [PHAsset]()
    var img = [UIImage]()

    let imagePickerController = ImagePickerController()


//MARK:- VIEWDID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        continueView.layer.cornerRadius = 20
//        imagePickerController.imageLimit = 6
   
//        config.allowMultiplePhotoSelection = true
//        let imagePicker = ImagePickerController(configuration: config)
//        imagePickerController.delegate = self
        print(name);print(email);print(phone);print(dob)
        imagePickerController.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageCollection.collectionViewLayout = layout
        imageCollection.backgroundColor = .white
        
        let gesture = UILongPressGestureRecognizer(target: self, action:  #selector(gestureRecognizer))
        imageCollection.addGestureRecognizer(gesture)
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
            self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
    }

    func hello(){
        
        self.presentImagePicker(self.imagePickerController, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
            print("dnvkdsbkdbkvjb")

        }, finish: { (assets) in
            // User finished selection assets.
            print("jsdjbfkjebwfj")
            for i in 0..<assets.count{
                self.selectedAsset.append(assets[i])
//                self.convertAssestToImage()
            }
        })
    }
    

//    func convertAssestToImage(){
//        self.img.removeAll()
//        self.myimage.removeAll()
//
//        for i in 0..<selectedAsset.count {
//
//                    let manager = PHImageManager.default()
//                    let option = PHImageRequestOptions()
//                    var thumbnail = UIImage()
//                    option.isSynchronous = true
//                    manager.requestImage(for: selectedAsset[i],targetSize: CGSize(width: 200, height: 200), contentMode: PHImageContentMode.aspectFill, options: option, resultHandler: { (result, info) -> Void in
//                        thumbnail = result!
//                    })
//
//                    let data = thumbnail.jpegData(compressionQuality: 0.7)
//                    let newImage = UIImage(data: data!)
//                    self.img.append(newImage! as UIImage)
//                        // This for send images data to another view cntroller for make request
//                    self.myimage.append(data!)
//
//                    }
//
//                    DispatchQueue.main.async {
//                      self.imageCollection.reloadData()
//                    }
//
//                }
//
//                print("complete photo array \(self.photoArray)")
//}
//}
    
//MARK:- IMAGEPICKER METHOD
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("hellowrapper")
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("hellodone")
        print(images)
        img.removeAll()
        img = images
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
        imageCollection.reloadData()
        dismiss(animated: true, completion: nil)
    }

    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        print("hellocancel")
    }
//MARK:- GESTURE METHOD
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

//MARK:- BUTTON ACTION
   
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
        self.navigationController?.pushViewController(vc, animated: true)
        
//if education.text == "" || aboutMe.text == "" || selectCityText.text == "" || height.text == "" || weight.text == "" || favouriteSport.text == "" || eduDegree.text == "" || lookingFor.text == "" || myWork.text == "" {
//            alert(message: "Please enter all fields")
//        }else{
//            let modelLoc = loction(type: "hello", cordinates: [2.2,2.323])
//            let model = UpdateUser(name: name, email: email, phoneNo: phone, dob: dob, school: education.text!, aboutMe: aboutMe.text!, livingIn: selectCityText.text!, height: height.text!, weight: weight.text!, favSports: favouriteSport.text!, degreeOfEducation: eduDegree.text!, lookingFor: lookingFor.text!, myWork: myWork.text!, loc: modelLoc)
//            print(model)
//            ApiManager.shared.update(model: model) { (isSuccess) in
//                if isSuccess{
        MBProgressHUD.hide(for: self.view, animated: true)
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    print("hello")
//                }else{
        MBProgressHUD.hide(for: self.view, animated: true)
//                    print("Failure")
//                }
//            }
//        }
     
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK:- extension
extension PersonalInformation2VC{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if img.count != 0{
            return img.count
        }else{
            return imagee.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InformationCell
        if img.count == 0{
            cell.picSelected.image = imagee[indexPath.item]
        }
        else{
            cell.picSelected.image = img[indexPath.item]
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       hello()
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


extension PersonalInformation2VC{
    func upload(image: [UIImage],
                      progressCompletion: @escaping (_ percent: Float) -> Void,
                      completion: @escaping (_ result: Bool) -> Void) {
//              guard let imageData = image.jpegData(compressionQuality: 0.5) else {
//              print("Could not get JPEG representation of UIImage")
//              return
//            }
       
            let randomno = Int.random(in: 1000...100000)
           let imgFileName = "image\(randomno).jpg"
        
            
//        let parameterS: Parameters = ["id": "\(UserDefaults.standard.value(forKey: "userid")!)"]
        let userId = UserDefaults.standard.value(forKey: "id") as! String
            AF.upload(
              multipartFormData: { multipartFormData in
                
                for i in 0...image.count-1{
                                    
                    multipartFormData.append(image[i].jpegData(compressionQuality: 0.5)!,
                                             withName: "files[]",
                                             fileName: imgFileName,
                                             mimeType: "image/jpeg")
                               
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
