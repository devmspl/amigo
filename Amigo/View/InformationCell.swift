//
//  InformationCell.swift
//  Amigo
//
//  Created by mac on 27/10/2021.
//

import UIKit

class InformationCell: UICollectionViewCell {
    @IBOutlet weak var picSelected: UIImageView!
    
    override func awakeFromNib() {
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
