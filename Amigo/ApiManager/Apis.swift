//
//  Apis.swift
//  Amigo
//
//  Created by mac on 09/11/2021.
//

import Foundation

public var baseUrl = "http://93.188.167.68:8001/api/"

public struct API{
    
//MARK: - USER API
    public static let signUp              = baseUrl+"users/create"
    public static let login               = baseUrl+"users/login"
    public static let update              = baseUrl+"users/update/"
    public static let userList            = baseUrl+"users/matchList"
    public static let forgot              = baseUrl+"users/forgotPassword"
    public static let getUser             = baseUrl+"users/currentUser/"
    
//MARK: - FAVOURITE API
    public static let favourite           = baseUrl+"favourites/add"
    public static let favRemove           = baseUrl+"favourites/remove"
    public static let favList             = baseUrl+"favourites/ByUserId/"
    
//MARK: - REQUESTAPI
    public static let addrequest          = baseUrl+"requests/createRequest"
    public static let acceptRequest       = baseUrl+"requests/approve/"
    public static let rejectRequest       = baseUrl+"requests/reject/"
    public static let requestList         = baseUrl+"requests/listByUserId/"
    
}
