//
//  PersonalInformation2VC.swift
//  Amigo
//
//  Created by mac on 21/10/2021.
//

import UIKit

class PersonalInformation2VC: UIViewController {

    @IBOutlet weak var imageCollection: UICollectionView!
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
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var continueView: UIView!
    
    let img = [UIImage.init(named: "photo"),UIImage.init(named: "photo"),UIImage.init(named: "photo"),UIImage.init(named: "photo"),UIImage.init(named: "photo"),UIImage.init(named: "photo")]
    override func viewDidLoad() {
        super.viewDidLoad()
        continueView.layer.cornerRadius = 20
    }
    

    @IBAction func editTapped(_ sender: Any) {
        print("fdhdf")
    }
    @IBAction func selectCityBtn(_ sender: Any) {
        print("fdfgshdf")
    }
    
    @IBAction func previewTapde(_ sender: Any) {
        print("fddfgshdf")
    }
    @IBAction func continueTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK:- extension
extension PersonalInformation2VC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InformationCell
        cell.picSelected.image = img[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollection.frame.width/3, height: imageCollection.frame.height/2.1)
    }
    
}
