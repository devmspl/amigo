//
//  ChatRecieveCell.swift
//  Amigo
//
//  Created by mac on 20/12/2021.
//

import UIKit

class ChatRecieveCell: UITableViewCell {

    @IBOutlet weak var receiveMsg: UILabel!
    @IBOutlet weak var messageTime: UILabel!
    @IBOutlet weak var viewMsgRec: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMsgRec.backgroundColor = UIColor.clear
        viewMsgRec.layer.borderWidth = 1
        viewMsgRec.layer.borderColor = UIColor.gray.cgColor
        viewMsgRec.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  
    }

}
