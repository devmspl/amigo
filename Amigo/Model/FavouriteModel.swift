//
//  FavouriteModel.swift
//  Amigo
//
//  Created by mac on 26/11/2021.
//

import Foundation

struct AddToFavModel: Encodable{
    let userId: String?
    let toLikeUserId: String?
}

struct RemoveFavModel: Encodable {
    let userId: String?
    let toUnLikeUserId: String?
}
