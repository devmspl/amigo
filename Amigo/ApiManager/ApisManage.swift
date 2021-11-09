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
    let shared = ApiManager()
    
    func signUp(model: CreateUserModel, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(API.signUp, method: .post, parameters: model, encoder: JSONParameterEncoder.default).responseJSON{
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
            
        }
    }
}
