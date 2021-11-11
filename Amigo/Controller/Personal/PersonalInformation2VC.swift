//
//  PersonalInformation2VC.swift
//  Amigo
//
//  Created by mac on 21/10/2021.
//

import UIKit

class PersonalInformation2VC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

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
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var continueView: UIView!
    
    var img = [UIImage.init(named: "photo"),UIImage.init(named: "photo"),UIImage.init(named: "photo"),UIImage.init(named: "picLike"),UIImage.init(named: "photo"),UIImage.init(named: "photo")]
    override func viewDidLoad() {
        super.viewDidLoad()
        continueView.layer.cornerRadius = 20
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: imageCollection.frame.width/3.2, height: imageCollection.frame.height/2.2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        imageCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCollection.register(InformationCell.self, forCellWithReuseIdentifier: "cell")
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.backgroundColor = .blue
        
        let gesture = UILongPressGestureRecognizer(target: self, action:  #selector(gestureRecognizer))
        imageCollection.addGestureRecognizer(gesture)
    }
    
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
extension PersonalInformation2VC{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InformationCell
        cell.picSelected.image = img[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollection.frame.width/4, height: imageCollection.frame.height/2.1)
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = img.remove(at: sourceIndexPath.row)
        img.insert(item, at: destinationIndexPath.row)
    }
}
