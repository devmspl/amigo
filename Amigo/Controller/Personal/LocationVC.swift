//
//  LocationVC.swift
//  Amigo
//
//  Created by mac on 25/11/2021.
//

import UIKit

class LocationVC: UIViewController {

    @IBOutlet weak var locationBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.value(forKey: "Gender") as! String == "male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
            self.locationBtn.backgroundColor = UIColor(named: "girlButton")
        }
    }
    
    @IBAction func locationTapped(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
