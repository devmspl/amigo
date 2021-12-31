//
//  ChatVC.swift
//  Amigo
//
//  Created by mac on 16/11/2021.
//

import UIKit
import SocketIO

class ChatVC: UIViewController {
    
    var arraySendMessage = [AnyObject]()
     
    @IBOutlet weak var nameUser: UILabel!
    var sendmasg = "0"
    var roomID = String()
   // var username = ""
    var status = ""
    var sendLink = ""
    var img = ""
    var friendId = ""
    var OldData = 0
     
    var msgFrom = ""
    var msgTo = ""
    var msg = ""
    var date = ""
    var totalMsg = 0



    var arraymsgFrom = [AnyObject]()
    var arraymsgTo = [AnyObject]()
    var arraymsg = [AnyObject]()
    var arraydate = [AnyObject]()
     
    var Int = 1;
    var id = 1 ;

    @IBOutlet weak var chatTable: UITableView!{
        didSet{
            chatTable.tableFooterView = UIView(frame: .zero)
        }
    }
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var textMessage: UITextField!
    var sendMsgarr = ["a","b","a","b","a","b","a","b"]
    var receiveMsgarr = ["a","b","a","b","a","b","a","b"]
    
    
    var messages : [MessageData] = [MessageData( text: "dsfsdfsdf", isFirstUser: true),MessageData( text: "abhaydfsdf", isFirstUser: false),MessageData( text: "sahildfsdf", isFirstUser: true)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "Gender") as! String == "male"{
            self.view.backgroundColor = UIColor(named: "MenColor")
        }else{
            self.view.backgroundColor = UIColor(named: "girlColor")
//          self.continueView.backgroundColor = UIColor(named: "girlButton")
        }
        
        let userid = UserDefaults.standard.value(forKey: "id") as! String
        
        socket.connect()
        print(roomID)
     
        socket.on("connect"){ data, ack in
        print("socket connected")
         
        socket = manager.defaultSocket;
        socket.joinNamespace()
            
            socket.emit("set-user-data",userid)
            print(userid)
            socket.emit("set-room" , ["covsersatioFrom" : userid,"covsersatioTo": "61bd812bb51cba4379d99625"])
            
        }
        self.chatTable.delegate = self
       addHandlers()
    }
    
    @IBAction func backTapped(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func sendTepped(_ sender: Any){
        let userid = UserDefaults.standard.value(forKey: "id") as! String

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //  df.dateFormat = "dd MMM yyyy"
        let endDate = df.string(from: Date())
        let d = df.date(from: endDate)!
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let enddd = df.string(from: d)
        let text = "\(self.textMessage.text!)"
        print(text)
        print(self.id)
        arraySendMessage.removeAll()
        arraySendMessage.append((self.textMessage.text!) as AnyObject)
        socket.emit("chat-msg",["msg" : arraySendMessage[0],"sender" :userid,"date" : enddd])
    }
    
    func addHandlers()
    {
        self.oldCHATSSSS()
        
        socket.on("typing"){ data, ack in
              print("typing Data==== ", data)
              //self.lbl_Usertyping.text = "\(data)"
        }
            socket.on("chat-msg"){ data, ack in

                if let dic = data[0] as? [String:AnyObject]{
                           
                   let Messages = dic as NSDictionary
                   let msg = Messages.value(forKey: "msg")
                   let dateFromMessage = Messages.value(forKey: "date")
                   let msgfrom = Messages.value(forKey: "msgFrom")
                  // let msgTo = Messages.value(forKey: "toMsg")

                  // let name = UserDefaults.standard.value(forKey: "userName") as! String
                   self.arraymsgFrom.append(msgfrom as AnyObject)
                   self.arraymsgTo.append("ASHISH" as AnyObject)
                   self.arraymsg.append(msg as AnyObject)
                   self.arraydate.append(dateFromMessage as AnyObject)
            

                   
                   self.textMessage.text = ""
                   
                   self.chatTable.reloadData()
                   self.scrollToBottom()
                   // self.playSoundReceived()
               }

                   //self.arraydate.removeAll()
        }
          socket.on("typing"){ data, ack in
              print("typing Data==== ", data)
            //  self.lbl_Usertyping.text = "Typing..."
          }
    }
    
    func oldCHATSSSS()
    {
        socket.on("set-room"){ data, ack in
                 // }
         }
    }
    
    func scrollToBottom(){
             if self.arraymsg.count != 0 {
             let indexPath = IndexPath(row: self.arraymsg.count-1, section: 0)
             self.chatTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            //    if (self.arraymsg.count != -1){
                 print("indexPath.row==\(indexPath.row)")
          //  }
        }
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
        cell.selectionStyle = .none
                 print("kisda h ",arraymsgFrom[indexPath.row])
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
                cell.selectionStyle = .none
                cell.receiveMsg.text = self.arraymsg[indexPath.row] as? String
                cell.messageTime.text = self.arraydate[indexPath.row] as? String
                return cell
              }
        return cell
       }
        
    }
    


