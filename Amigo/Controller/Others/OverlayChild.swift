//
//  OverlayChild.swift
//  Amigo
//
//  Created by mac on 12/11/2021.
//

import UIKit

class OverlayChild: UIView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var picOutlet: UIImageView!
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var distanceOutlet: UILabel!
    
    override func awakeFromNib() {
        picOutlet.layer.cornerRadius = 20
        mainView.layer.cornerRadius = 20
//        mainView.layer.borderWidth = 1
//        mainView.layer.borderColor = UIColor.darkGray.cgColor
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 3, height: 3)
        mainView.layer.shadowRadius = 5
        mainView.layer.shadowOpacity = 10
    }
}
