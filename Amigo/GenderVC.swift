//
//  GenderVC.swift
//  Amigo
//
//  Created by mac on 21/10/2021.
//

import UIKit

class GenderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func maleTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalInformation1VC") as! PersonalInformation1VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func womenTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PersonalInformation1VC") as! PersonalInformation1VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
