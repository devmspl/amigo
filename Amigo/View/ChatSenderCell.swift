//
//  ChatSenderCell.swift
//  Amigo
//
//  Created by mac on 20/12/2021.
//

import UIKit

class ChatSenderCell: UITableViewCell {

    @IBOutlet weak var sendMsg: UILabel!
    @IBOutlet weak var msgTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
