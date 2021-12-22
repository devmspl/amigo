//
//  ChatVC.swift
//  Amigo
//
//  Created by mac on 16/11/2021.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var chatTable: UITableView!{
        didSet{
            chatTable.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var textMessage: UITextField!
    var sendMsgarr = ["a","b","a","b","a","b","a","b"]
    var receiveMsgarr = ["a","b","a","b","a","b","a","b"]
    
    
    var arraymsgFrom = ["a","b","a","b","a","b","a","b"]
    var arraymsgTo = ["ad","bd","da","db","ad","bd","da","db"]
    var arraymsg = ["a","b","a","b","a","b","a","b"]
    var arraydate = ["34","345","45","45","45","4","4","3"]
    
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


//MARK: - TABLE VIEW DELEGATE AND DATA SOURCE

extension ChatVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arraymsg.count > 0
        {
            return self.arraymsg.count
            //            self.tbl_ChatList.reloadData()
        }
        else
        {
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                let cell = chatTable.dequeueReusableCell(withIdentifier: "cell") as! ChatSenderCell
                let name = UserDefaults.standard.value(forKey: "id") as! String
        

                if self.arraymsgFrom[indexPath.row] as! String == name{
//                     cell.sendMsg.roundCorners([.bottomRight,.bottomLeft,.topLeft], radius: 18)
                cell.sendMsg.text = self.arraymsg[indexPath.row] as? String
                    
                    let arrStr = Array("\(self.arraydate[indexPath.row] as! String)")
                    
                    print("checkkkkkkkkkkk thissssss \(arrStr)")
                    cell.msgTime.text =  String(arrStr[11..<16])
                return cell
              }
               if self.arraymsgFrom[indexPath.row] as! String != name{
                let cell = chatTable.dequeueReusableCell(withIdentifier: "cellReceive") as! ChatRecieveCell
//                cell.chatView2.roundCorners([.bottomRight,.bottomLeft,.topRight], radius: 18)
                cell.receiveMsg.text = self.arraymsg[indexPath.row] as? String
                cell.messageTime.text = self.arraydate[indexPath.row] as? String
                return cell
              }
        return cell
       }
        
    }
    


