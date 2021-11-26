//
//  ChatVC.swift
//  Amigo
//
//  Created by mac on 16/11/2021.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var textMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
//          self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
       
    }
    
    @IBAction func backTapped(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func sendTepped(_ sender: Any){
        
    }
}
