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
    @IBOutlet weak var settingTable: UITableView!{
        didSet{
            settingTable.tableFooterView = UIView(frame: .zero)
        }
    }
    let setarray = ["Terms and conditions","Privacy policy","Support","Change password","Sign out"]
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

class SettingCell: UITableViewCell{
    
    @IBOutlet weak var setCategory: UILabel!
}

extension SettingVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTable.dequeueReusableCell(withIdentifier: "cell") as! SettingCell
        cell.setCategory.text = setarray[indexPath.row]
        return cell
    }
    
    
    
}
