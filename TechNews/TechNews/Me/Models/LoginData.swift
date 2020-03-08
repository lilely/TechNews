//
//  LoginData.swift
//  TechNews
//
//  Created by 金星 on 2020/2/28.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

final class LoginData: ObservableObject {
    
    @Published var loginModel: LoginModel?
    
    func login(withAccount accountID: String,andPassword password: String,_ completion: @escaping (LoginModel?, Error?)->Void) {
        
        let originUrl = "https://localhost:8181/user/signin"
        let bodyDic = [
            "account": accountID,
            "password": password
        ]
        TNNetworkAPIRequest<LoginModel>(originUrl, .post)
            .data(bodyDic)
            .start{ (loginModel,error) -> Void in
                if let loginModel = loginModel {
                    print("Login Success!")
                    self.loginModel = loginModel
                    completion(loginModel,nil)
                } else {
                    print(error ?? "Unkonw error")
                    completion(nil,error)
                }
        }
    }
    
    func logout(withAccount accountID: String, _ completion: @escaping (LoginModel?, Error?)->Void) {
        
    }
    
    func register(withAccount accountID: String,andPassword password: String, _ completion: @escaping (LoginModel?, Error?)->Void) {
        let originUrl = "https://localhost:8181/user/signup"
        let bodyDic = [
            "account": accountID,
            "password": password
        ]
        TNNetworkAPIRequest<LoginModel>(originUrl, .post)
            .data(bodyDic)
            .start { (loginModel,error) in
                if let loginModel = loginModel {
                    print("Register Success!")
                    self.loginModel = loginModel
                    completion(loginModel,nil)
                } else {
                    print(error ?? "Unkonw error")
                    completion(nil,error)
                }
        }
    }
    
}
