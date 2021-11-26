//
//  SettingVC.swift
//  Amigo
//
//  Created by mac on 25/11/2021.
//

import UIKit

class SettingVC: UIViewController {

    
    @IBOutlet weak var nameOut: UILabel!
    @IBOutlet weak var emailOut: UILabel!
    @IBOutlet weak var settingTable: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

     
        
    }
    

    
}

class SettingCell: UITableViewCell{
    
}

extension SettingVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTable.dequeueReusableCell(withIdentifier: "cell") as! SettingCell
        return cell
    }
    
    
    
}
