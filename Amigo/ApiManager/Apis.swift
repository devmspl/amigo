//
//  Apis.swift
//  Amigo
//
//  Created by mac on 09/11/2021.
//

import Foundation

public var baseUrl = "http://93.188.167.68:8001/api/"

public struct API{
    public static let signUp              = baseUrl+"users/create"
    public static let login               = baseUrl+"users/login"
    public static let update              = baseUrl+"users/update/"
}
