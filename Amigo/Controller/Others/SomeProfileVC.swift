//
//  SomeProfileVC.swift
//  Amigo
//
//  Created by mac on 29/10/2021.
//

import UIKit

class SomeProfileVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var work: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var upperCollection: UICollectionView!
    @IBOutlet weak var lowerCollection: UICollectionView!
    
    let label = ["Interest1","Interest2","Interest3","Interest4"]
    let image = [UIImage(named: "pic4")]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == upperCollection{
            return 1
        }else{
            return label.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == upperCollection{
            let cell = upperCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UpperCollectionCell
            return cell
        }else{
            let cell = lowerCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LowerCollectionCell
            cell.labelout.text = label[indexPath.row]
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == lowerCollection{
            return CGSize(width: lowerCollection.frame.width/4.5, height: lowerCollection.frame.height)
        }else{
            return CGSize(width: lowerCollection.frame.width, height: lowerCollection.frame.height)

        }
        
    }
    
    @IBAction func optionBtn(_ sender: Any) {
    }
    
}
class UpperCollectionCell: UICollectionViewCell{
    @IBOutlet weak var imageupper: UIImageView!
}
class LowerCollectionCell: UICollectionViewCell{
    @IBOutlet weak var viewInterest: UIView!
    @IBOutlet weak var labelout: UILabel!
}

