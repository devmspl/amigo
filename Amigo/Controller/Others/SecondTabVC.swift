//
//  SecondTabVC.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit
import Koloda

class SecondTabVC: UIViewController {
    
    

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var swipeView: KolodaView!
    @IBOutlet weak var picOut: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeView.delegate = self
        swipeView.dataSource = self
        swipeView.layer.cornerRadius = 20
        
        ApiManager.shared.userList { (success) in
            if success{
                print("success")
            }
        }
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
            self.backgroundImage.image = UIImage(named: "Background")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
            self.backgroundImage.image = UIImage(named: "backGirl")
//            self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
        
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
//          self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
    }
    
    @IBAction func dislikeBtn(_ sender: Any) {
        swipeView.swipe(.left)
        print("dislike")
    }
    @IBAction func refreshBtn(_ sender: Any) {
        print("refresh")
    }
    
    @IBAction func likeBtn(_ sender: Any) {
        swipeView.swipe(.right)
        print("like")
    }
    @IBAction func lightningBtn(_ sender: Any) {
        print("Light")
    }
    @IBAction func superLikeBtn(_ sender: Any) {
        swipeView.swipe(.up)
        print("Super")
    }
    
}

extension SecondTabVC: KolodaViewDelegate{
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection)
    {

        DispatchQueue.main.asyncAfter(deadline: .now()+10.0) {
            
            if direction == .left {
             
             }
             if direction == .right {
                
             }
            if direction == .up{
                
            }
            if direction == .down{
                
            }
            
        }
      }
    
    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right, .up, .down]
    }

    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
         let vc = self.storyboard!.instantiateViewController(
                                 withIdentifier: "SomeProfileVC") as! SomeProfileVC
//               vc.Propertyid = HomelistArray[index]["_id"] as! String
               self.navigationController?.pushViewController(vc, animated: true)
       
    }
}
extension SecondTabVC: KolodaViewDataSource{
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
         koloda.resetCurrentCardIndex()
           koloda.reloadData()
        
       }

    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        
        return 10
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
    }

    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let overlay1 = (Bundle.main.loadNibNamed("slider", owner: self, options: nil)?[0] as! OverlayChild)
//        koloda.reloadData()
        return overlay1
       
    }
    
    

    
}
