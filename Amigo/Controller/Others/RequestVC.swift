//
//  LikeVC.swift
//  Amigo
//
//  Created by mac on 19/11/2021.
//

import UIKit

class RequestVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var likeTable: UITableView!{
        didSet{
            likeTable.tableFooterView = UIView(frame: .zero)
        }
    }
    let nameArray = ["Anika","Sherya","Lilly","Mona","Sonia"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func deleteRequest(_ sender: UIButton) {
        likeTable.reloadData()
    }
    @IBAction func acceptRequest(_ sender: Any) {
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likeTable.dequeueReusableCell(withIdentifier: "cell") as! RequestTableCell
        cell.cellName.text = nameArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "SomeProfileVC") as! SomeProfileVC
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }


}
