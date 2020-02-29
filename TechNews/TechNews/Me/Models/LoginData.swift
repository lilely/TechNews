//
//  LoginData.swift
//  TechNews
//
//  Created by 金星 on 2020/2/28.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation
import Alamofire

final class LoginData: ObservableObject {
    
    @Published var loginModel: LoginModel?
    
    @Published var error: Error?
    
    func login(withAccount accountID: String,andPassword password: String) {
        
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
                } else {
                    print(error ?? "Unkonw error")
                    self.error = error
                }
        }
    }
    
    func register(withAccount accountID: String,andPassword password: String) {
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
                } else {
                    print(error ?? "Unkonw error")
                    self.error = error
                }
        }
    }
    
}
