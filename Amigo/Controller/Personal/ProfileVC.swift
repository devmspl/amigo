//
//  ProfileVC.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func imageChange(_ sender: Any) {
    }
    
}
