//
//  ApisManage.swift
//  Amigo
//
//  Created by mac on 09/11/2021.
//

import Foundation
import Alamofire
import MBProgressHUD
import UIKit

class ApiManager: UIViewController{
    static let shared = ApiManager()
    var message = ""
    var error = ""
    //MARK: - signUp api
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
                        self.alert(message: "An error occured please try again")
                        print("Completion false")
                        completionHandler(false)
                    }
                }catch{
                    print(error.localizedDescription)
                    completionHandler(false)
                }
                case .failure(let error): do{
                    print("Error",error)
                    self.alert(message: "An error occured please try again")
                    completionHandler(false)
                }
                }
                
            }
        }else{
            completionHandler(false)
            alert(message: "Please check internet connection")
        }
    }
    
    //MARK: - loginAPi
    func login(model: LoginModel, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print(model)
            AF.request(API.login, method: .post, parameters: model, encoder: JSONParameterEncoder.default).response{
                response in
                switch(response.result){
                case .success(let data):
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print(json)
                        let respond = json as! NSDictionary
                        if response.response?.statusCode == 200 {
                            //                            ARSLineProgress.hide()
                            let data = respond.object(forKey: "data") as! NSDictionary
                            let userId = data.object(forKey: "id") as! String
                            let token = response.response?.allHeaderFields["x-access-token"] as! String
                            print(userId)
                            let gender = data.object(forKey: "sex") as? String ?? ""
                            let name = data.object(forKey: "name") as? String ?? ""
                            UserDefaults.standard.setValue(userId, forKey: "id")
                            UserDefaults.standard.setValue(token, forKey: "token")
                            UserDefaults.standard.setValue(gender, forKey: "Gender")
                            UserDefaults.standard.setValue(name, forKey: "name")
                            print(UserDefaults.standard.value(forKey: "Gender"),"hdfhvfhgvershgv")
                            print(UserDefaults.standard.value(forKey: "name"),"hdfhvfhgvershgv")
                            print(userId)
                            print(token)
                            completionHandler(true)
                        }else{
                            if let message = respond.object(forKey: "error") as? String{
                                self.message = message
                                print(self.message)
                          }
                            completionHandler(false)
                          }
                    }catch{
                        print(error.localizedDescription)
                        completionHandler(false)
                        self.alert(message: "An error occured please try again")
                        
                        //                        ARSLineProgress.hide()
                    }
                case .failure(let error): do{
                    print("Error",error)
                    completionHandler(false)
                }
                }
            }
        }else{
            self.alert(message: "Please check internet connection")
            
            completionHandler(false)
        }
    }
    
    //MARK: - FORGET PASSWORD API
    func forgetApi(model: ForgotPassModel,completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(API.forgot, method: .post, parameters: model ,encoder: JSONParameterEncoder.default).response{
                response in
                switch(response.result){
                
                case .success(let data):
                    do{
                        print(data)
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print(json)
                        let respond = json as! NSDictionary
                        if response.response?.statusCode == 200{
                            completionHandler(true)
                            let data = respond.object(forKey: "data") as! NSDictionary
                            let token = data.object(forKey: "token") as! String
                            UserDefaults.standard.setValue(token, forKey: "token")
                        }else{
                            if let err = respond.object(forKey: "error") as? String{
                                self.error = err
                            }
                            completionHandler(false)
                        
                        }
                        
                    }catch{
                        print(error.localizedDescription)
                        completionHandler(false)
                        self.alert(message: "An error occured please try again")
                    }
                    
                case .failure(let error):do{
                    print(error)
                    completionHandler(false)
                    self.alert(message: "Please check internet connection")
                }
                
                }
                
            }
        }
    }
    
//MARK: - OTP API
    
    func otpApi(model: OTPModel, completionHandler: @escaping (Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head : HTTPHeaders = ["x-access-token": token]
            AF.request(API.otp,method: .post,parameters: model,headers: head).response{
                response in
                switch(response.result){
                case .success(let data):do{
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options:  [])
                    let respond = json as! NSDictionary
                    let message = respond.object(forKey: "message") as! String
                    if response.response?.statusCode == 200{
                        completionHandler(true)
                        self.alert(message: message)
                        print("success",respond)
                    }else{
                        self.alert(message: message)
                    }
                }catch{
                    completionHandler(false)
                    self.alert(message: "Something went wrong please try again")
                    print(error.localizedDescription)
                }
               
                case .failure(let error):do{
                    completionHandler(false)
                    print(error.localizedDescription)
                    self.alert(message: "Something went wrong please try again")
                }
                }
            }
        }else{
            completionHandler(false)
            self.alert(message: "Please check internet connection")
        }
    }
    
//MARK: - RESETPASSWORD
    func resetPassword(model: ResetPassModel, completionHandler: @escaping (Bool)-> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head : HTTPHeaders = ["x-access-token": token]
            AF.request(API.resetpass,method: .post,parameters: model,headers: head).response{
                response in
                switch(response.result){
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:  [])
                    let respond = json as! NSDictionary
                    let message = respond.object(forKey: "message") as! String
                    if response.response?.statusCode == 200{
                        completionHandler(true)
                        self.alert(message: message)
                        print("success",respond)
                    }else{
                        self.alert(message: message)
                    }
                }catch{
                    completionHandler(false)
                    self.alert(message: "Something went wrong please try again")
                    print(error.localizedDescription)
                }
               
                case .failure(let error):do{
                    completionHandler(false)
                    print(error.localizedDescription)
                    self.alert(message: "Something went wrong please try again")
                }
                }
            }
        }else{
            completionHandler(false)
            self.alert(message: "Please check internet connection")
        }
    }
    
//MARK: - CHANGE PASSWORD
    func changePass(model: ChangePassModel,completionHandler: @escaping (Bool) ->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let userId = UserDefaults.standard.value(forKey: "id") as! String
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let head: HTTPHeaders = ["x-access-token": token]
            print(API.changePass+userId)
            
            print(token)
            AF.request(API.changePass+userId, method: .put, parameters: model, headers: head).response{
                response in
                switch(response.result){
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let respond = json as! NSDictionary
                    print(respond)
                    if response.response?.statusCode == 200{
                        print("success",respond)
                        if let message = respond.object(forKey: "message") as? String{
                            self.message = message
                        }
                        completionHandler(true)
                    }else{
                       if let msg = respond.object(forKey: "error") as? String{
                        self.message = msg
                       }
                        completionHandler(false)
                    }
                }catch{
                    print("erroorrr===",error.localizedDescription)
                    completionHandler(false)
                }
                case .failure(let error): do{
                    print("erroorrr===",error.localizedDescription)
                    completionHandler(false)
                }
                }
            }
        }else{
            alert(message: "please check internet connection")
        }
    }
    // MARK: - update user
    
    func update(model: UpdateUser, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            
            let userId = UserDefaults.standard.value(forKey: "id") as! String
            let token = UserDefaults.standard.value(forKey: "token") as! String
            
            let header: HTTPHeaders = ["x-access-token": token]
            print(UpdateUser.self)
            AF.request(API.update+userId, method: .put, parameters: model, encoder: JSONParameterEncoder.default,headers: header).response{
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
                            self.alert(message: "An error occured please try again")
                            completionHandler(false)
                            //                            ARSLineProgress.hide()
                        }
                    }catch{
                        print(error.localizedDescription)
                        completionHandler(false)
                        self.alert(message: "An error occured please try again")
                        //                        ARSLineProgress.hide()
                    }
                case .failure(let error): do{
                    print("Error",error)
                    self.alert(message: "An error occured please try again")
                    completionHandler(false)
                }
                }
            }
        }else{
            self.alert(message: "Please check internet connection")
            
            completionHandler(false)
        }
    }
    
    //MARK: - FAVOURITE
    
    func favouriteApi(model: AddToFavModel, completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            //            let header: HTTPHeaders = ["x-access-token": token]
            AF.request(API.favourite, method: .post, parameters: model, encoder: JSONParameterEncoder.default).response{
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
                            self.alert(message: "An error occured please try again")
                            completionHandler(false)
                            //                            ARSLineProgress.hide()
                        }
                    }catch{
                        print(error.localizedDescription)
                        completionHandler(false)
                        self.alert(message: "An error occured please try again")
                        //                        ARSLineProgress.hide()
                    }
                case .failure(let error): do{
                    print("Error",error)
                    self.alert(message: "Please check internet conection")
                    completionHandler(false)
                }
                }
            }
        }else{
            completionHandler(false)
        }
    }

//MARK: - REMOVE FAVOURITE
    
    func removeFav(model: RemoveFavModel,completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            AF.request(API.favRemove,method: .post,parameters: model,encoder: JSONParameterEncoder.default).response{
                response in
                switch(response.result){
                
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    let respond = json as! NSDictionary
                    let message = respond.object(forKey: "message") as! String
                    if response.response?.statusCode == 200{
                        
                        print("Success",respond)
                        completionHandler(true)
                    }else{
                        self.alert(message: message)
                    }
                }catch{
                    self.alert(message: "Something went wrong please try again")
                    print("Errorrr",error.localizedDescription)
                    completionHandler(false)
                }
                    
                case .failure(let error):do{
                    self.alert(message: "Something went wrong please try again")
                    print("Errorrr",error.localizedDescription)
                    completionHandler(false)
                }
                }
            }
        }else{
            self.alert(message: "Please check your internet connection")
        }
    }
    
    // MARK: - add request api
    func requestApi(model: AddReqModel,completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            print(API.addrequest)
            let token = UserDefaults.standard.value(forKey: "token") as! String
            print("xzbjkasbbdsavbdajbvjadbv",token)
            let head : HTTPHeaders = ["x-access-token":token]
            AF.request(API.addrequest, method: .post, parameters: model ,encoder: JSONParameterEncoder.default,headers: head).response{
                response in
                switch(response.result){
                case .success(let data):
                    do{
                        print(data)
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print(json)
                        if response.response?.statusCode == 200{
                            completionHandler(true)
                        }else{
                            completionHandler(false)
                            self.alert(message: "An error occured please try again")
                        }
                        
                    }catch{
                        print(error.localizedDescription)
                        completionHandler(false)
                        self.alert(message: "An error occured please try again")
                    }
                    
                case .failure(let error):do{
                    print(error)
                    completionHandler(false)
                    self.alert(message: "Please check internet connection")
                }
                
                }
                
            }
        }else{
            completionHandler(false)
            self.alert(message: "Please check internet connection")
        }
    }
    
    //MARK: - APPROVE REQUEST
    func approveReq(id:String,completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headere : HTTPHeaders = ["x-access-token":token]
            AF.request(API.acceptRequest+id,method: .put,headers: headere).response{
                response in
                switch(response.result){
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200{
                        print("success",json)
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                        print("failed",json)
                    }
                }catch{
                    completionHandler(false)
                    print(error.localizedDescription)
                    self.alert(message: "An error occured please try again")
                }
                case .failure(let error):do{
                    completionHandler(false)
                    print(error.localizedDescription)
                    self.alert(message: "An error occured please try again")
                }
                }
            }
        }else{
            completionHandler(false)
            self.alert(message: "An error occured please try again")
        }
    }

//MARK: - DELETEREQUEST
    func rejectReq(id:String,completionHandler: @escaping (Bool) -> ()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            let token = UserDefaults.standard.value(forKey: "token") as! String
            print("token",token)
            let headere : HTTPHeaders = ["x-access-token":token]
            AF.request(API.rejectRequest+id,method: .put,headers: headere).response{
                response in
                switch(response.result){
                case .success(let data):do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if response.response?.statusCode == 200{
                        print("success",json)
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                        print("failed",json)
                    }
                }catch{
                    completionHandler(false)
                    print(error.localizedDescription)
                    self.alert(message: "An error occured please try again")
                }
                case .failure(let error):do{
                    completionHandler(false)
                    print(error.localizedDescription)
                    self.alert(message: "An error occured please try again")
                }
                }
            }
        }else{
            completionHandler(false)
            self.alert(message: "An error occured please try again")
        }
    }
}






extension UIViewController {
    
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
    
 // showAlertWithOneAction
 func showAlertWithOneAction(alertTitle:String, message: String, action1Title:String, completion1: ((UIAlertAction) -> Void)? = nil){
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: action1Title, style: .default, handler: completion1))
            self.present(alert, animated: true, completion: nil)
        }
    
//showAlertWithTwoActions
    func showAlertWithTwoActions(alertTitle:String, message: String, action1Title:String, action1Style: UIAlertAction.Style ,action2Title: String ,completion1: ((UIAlertAction) -> Void)? = nil,completion2 :((UIAlertAction) -> Void)? = nil){
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action1Title, style: action1Style, handler: completion1))
        alert.addAction(UIAlertAction(title: action2Title, style: .default, handler: completion2))
        self.present(alert, animated: true, completion: nil)
    }
}
