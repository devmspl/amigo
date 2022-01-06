//
//  UserModel.swift
//  Amigo
//
//  Created by mac on 08/11/2021.
//

import Foundation


struct CreateUserModel: Encodable{
    let email: String?
    let password: String?
}

struct LoginModel: Encodable {
    let email: String?
    let password: String?
}

struct ForgotPassModel: Encodable {
    let email: String?
}
struct OTPModel: Encodable {
    let otp: String?
}

struct ResetPassModel: Encodable {
    let newPassword: String?
}
struct ChangePassModel: Encodable {
    let oldPassword : String?
    let newPassword: String?
}

struct UpdateUser: Encodable {
    let name: String?
    let phoneNo: String?
    let dob: String?
    let school: String?
    let aboutMe: String?
    let livingIn: String?
    let height: String?
    let weight: String?
    let favSports:String?
    let degreeOfEducation: String?
    let lookingFor: String?
    let myWork: String?
    let sex: String?
    let loc: loction?
}

struct loction:Encodable {
    let type:String?
    let cordinates:[Double]
}

struct UsersData : Decodable{
    var data = [UsersModel.self]
    
    init(from decoder: Decoder) throws {
        self.data = [UsersModel.self]
    }
}

struct UsersModel: Decodable{
    let id: String?
}
