//
//  LikeTableCell.swift
//  Amigo
//
//  Created by mac on 19/11/2021.
//

import UIKit

class RequestTableCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellImage.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
