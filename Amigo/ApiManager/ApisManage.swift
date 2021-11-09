//
//  ApisManage.swift
//  Amigo
//
//  Created by mac on 09/11/2021.
//

import Foundation
import Alamofire
import MBProgressHUD

class ApiManager{
    static let shared = ApiManager()

//MARK:- signUp api
    func signUp(model: CreateUserModel, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(API.signUp, method: .post, parameters: model, encoder: JSONParameterEncoder.default).response{
                response in
                switch(response.result){
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 200{
                        completionHandler(true)
                    }else{
                        print("Completion false")
                    }
                }catch{
                    print(error.localizedDescription)
                    completionHandler(false)
                }
                case .failure(let error): do{
                    print("Error",error)
                    completionHandler(false)
                }
                }
                
            }
        }else{
            completionHandler(false)
        }
    }
    
//MARK:- loginAPi
    func login(model: LoginModel, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(API.login, method: .post, parameters: model, encoder: JSONParameterEncoder.default).response{
                response in
                switch(response.result){
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print(json)
                        if response.response?.statusCode == 200 {
//                            ARSLineProgress.hide()
                            completionHandler(true)
                        }else{
//                            ARSLineProgress.hide()
                        }
                    }catch{
                        print(error.localizedDescription)
                        completionHandler(false)
//                        ARSLineProgress.hide()
                    }
                case .failure(let error): do{
                    print("Error",error)
                    completionHandler(false)
                }
                }
            }
        }else{
            completionHandler(false)
        }
    }
}
