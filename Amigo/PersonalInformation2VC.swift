//
//  PersonalInformation2VC.swift
//  Amigo
//
//  Created by mac on 21/10/2021.
//

import UIKit

class PersonalInformation2VC: UIViewController {

    @IBOutlet weak var imageCollection: UICollectionView!
    
    let img = [UIImage.init(named: "photo"),UIImage.init(named: "photo"),UIImage.init(named: "photo"),UIImage.init(named: "photo"),UIImage.init(named: "photo"),UIImage.init(named: "photo")]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func editTapped(_ sender: Any) {
    }
    
    @IBAction func previewTapde(_ sender: Any) {
    }
    @IBAction func continueTapped(_ sender: Any) {
    }
}
class InformationTableCell: UICollectionViewCell{
    @IBOutlet weak var picSelected: UIImageView!
    
}

extension PersonalInformation2VC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InformationTableCell
        cell.picSelected.image = img[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollection.frame.width/3, height: imageCollection.frame.height/2.1)
    }
    
}
