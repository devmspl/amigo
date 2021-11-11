//
//  SecondTabVC.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit

class SecondTabVC: UIViewController {
    
    

    @IBOutlet weak var collectionSwipe: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func dislikeBtn(_ sender: Any) {
        print("dislike")
    }
    @IBAction func refreshBtn(_ sender: Any) {
        print("refresh")
    }
    
    @IBAction func likeBtn(_ sender: Any) {
        print("like")
    }
    @IBAction func lightningBtn(_ sender: Any) {
        print("Light")
    }
    @IBAction func superLikeBtn(_ sender: Any) {
        print("Super")
    }
    
}
class CollectionSwipe: UICollectionViewCell{
    
    @IBOutlet weak var collView: UIView!
    @IBOutlet weak var swipeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distance: UILabel!
    override func awakeFromNib() {
        collView.layer.cornerRadius = 20
        swipeImage.layer.cornerRadius = 20
    }
}



extension SecondTabVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionSwipe.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionSwipe
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SomeProfileVC") as! SomeProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionSwipe.frame.width, height: collectionSwipe.frame.height)
    }
    
}
