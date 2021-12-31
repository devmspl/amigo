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
    @IBOutlet weak var viewMsg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMsg.backgroundColor = UIColor.gray
        viewMsg.layer.borderWidth = 1
        viewMsg.layer.borderColor = UIColor.gray.cgColor
        viewMsg.layer.cornerRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
