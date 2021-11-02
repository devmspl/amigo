//
//  OrientationVC.swift
//  Amigo
//
//  Created by mac on 21/10/2021.
//

import UIKit
import StepSlider

class OrientationVC: UIViewController {

    @IBOutlet weak var sliderr: StepSlider!
    @IBOutlet weak var tableOreintation: UITableView!{
        didSet{
            tableOreintation.tableFooterView = UIView(frame: .zero)
        }
    }
    let array = ["Lesbian","Bisexual","Asexual","Demisexual","Queer","Bicurious","Aromantic","Bisexual"]
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func continueTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "GenderVC") as! GenderVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
class OrientationTableCell: UITableViewCell{
    @IBOutlet weak var orientationLabel: UILabel!
}

extension OrientationVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableOreintation.dequeueReusableCell(withIdentifier: "cell") as! OrientationTableCell
        
        cell.orientationLabel.text = array[indexPath.row]
        return cell
    }
    
    
}
