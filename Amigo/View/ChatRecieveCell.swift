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
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  
    }

}
