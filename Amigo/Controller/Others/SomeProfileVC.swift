//
//  SomeProfileVC.swift
//  Amigo
//
//  Created by mac on 29/10/2021.
//

import UIKit

class SomeProfileVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var picCollection: UICollectionView!
    @IBOutlet weak var dislike: UIButton!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var star: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var work: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var upperCollection: UICollectionView!
    @IBOutlet weak var lowerCollection: UICollectionView!
    
    let label = ["Interest1","Interest2","Interest3","Interest4","Interest5","Interest6","Interest7","Interest8"]
    let image = [UIImage(named: "pic4"),UIImage(named: "pic4"),UIImage(named: "pic4"),UIImage(named: "pic4")]
    let image2 = [UIImage(named: "pic4"),UIImage(named: "pic4"),UIImage(named: "pic4"),UIImage(named: "pic4")]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == upperCollection{
            return image.count
        }else if collectionView == picCollection{
            return image.count
        }else{
            return label.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == upperCollection{
            let cell = upperCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UpperCollectionCell
            cell.imageupper.image = image[indexPath.item]
            return cell
        }else if collectionView == picCollection{
            let cell = picCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PicCollectionCell
            cell.imageOut.image = image[indexPath.item]
            return cell
            
        }else{
            let cell = lowerCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LowerCollectionCell
            cell.labelout.text = label[indexPath.row]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == lowerCollection{
            return CGSize(width: lowerCollection.frame.width/4.5, height: lowerCollection.frame.height/3)
        }else if collectionView == upperCollection{
            return CGSize(width: upperCollection.frame.width, height: upperCollection.frame.height)
        }else{
            return CGSize(width: picCollection.frame.width/3.5, height: picCollection.frame.height/1.2)
        }
        
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
