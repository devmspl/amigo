//
//  UserModel.swift
//  Amigo
//
//  Created by mac on 08/11/2021.
//

import Foundation


struct CreateUserModel: Encodable{
    let phoneNo: String?
    let password: String?
}

struct LoginModel: Encodable {
    let phoneNo: String?
    let password: String?
}
