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

class PersonalInformation2VC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate {

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
    
    
//    let imagePickerController = ImagePickerController()
//    let config = Configuration()
  
   
    
    var img = [UIImage.init(named: "pic1"),UIImage.init(named: "pic2"),UIImage.init(named: "pic3"),UIImage.init(named: "picLike"),UIImage.init(named: "pic4"),UIImage.init(named: "pic2")]

//MARK:- VIEWDID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        continueView.layer.cornerRadius = 20
//        imagePickerController.imageLimit = 6
//        imagePickerController.delegate = self
//        config.allowMultiplePhotoSelection = true
//        let imagePicker = ImagePickerController(configuration: config)
//        imagePicker.delegate = self
        print(name);print(email);print(phone);print(dob)
        
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
        let imagePicker = ImagePickerController()
        
        self.presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets) in
            // User canceled selection.
        }, finish: { (assets) in
            // User finished selection assets.
        })
    }
    

//MARK:- IMAGEPICKER METHOD
//    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
//        print("hellowrapper")
//    }
//    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
//        print("hellodone")
//        print(images)
//        img.removeAll()
//        img = images
//        imageCollection.reloadData()
//        dismiss(animated: true, completion: nil)
//    }
//
//    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
//        print("hellocancel")
//    }
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
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    print("hello")
//                }else{
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
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InformationCell
        cell.picSelected.image = img[indexPath.item]
        
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
        let item = img.remove(at: sourceIndexPath.row)
        img.insert(item, at: destinationIndexPath.row)
    }
}
