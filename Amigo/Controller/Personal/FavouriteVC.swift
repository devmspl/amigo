//
//  FavouriteVC.swift
//  Amigo
//
//  Created by mac on 19/11/2021.
//

import UIKit

class FavouriteVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    

    @IBOutlet weak var favouriteTable: UITableView!{
        didSet{
            favouriteTable.tableFooterView = UIView(frame: .zero)
        }
    }
    let imgArr = [UIImage(named: "pic1"),UIImage(named: "pic2"),UIImage(named: "pic3"),UIImage(named: "pic4"),UIImage(named: "pic5")]
    let nameArr = ["Anika","Sherya","Lilly","Mona","Sonia"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "Male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
//            self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteTable.dequeueReusableCell(withIdentifier: "cell") as! FavouriteTableCell
        cell.img.image = imgArr[indexPath.row]
        cell.nameText.text = nameArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SomeProfileVC") as! SomeProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
