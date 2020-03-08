//
//  LoginData.swift
//  TechNews
//
//  Created by 金星 on 2020/2/28.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

final class AccountData: ObservableObject {
    
    @Published var account: Account?
    
    func login(withAccount accountID: String,andPassword password: String,_ completion: @escaping (Account?, Error?)->Void) {
        
        let originUrl = "https://localhost:8181/user/signin"
        let bodyDic = [
            "account": accountID,
            "password": password
        ]
        TNNetworkAPIRequest<Account>(originUrl, .post)
            .data(bodyDic)
            .start{ (account,error) -> Void in
                if let account = account {
                    print("Login Success!")
                    self.account = account
                    completion(account,nil)
                } else {
                    print(error ?? "Unkonw error")
                    completion(nil,error)
                }
        }
    }
    
    func logout(withAccount accountID: String, _ completion: @escaping (Account?, Error?)->Void) {
        
    }
    
    func register(withAccount accountID: String,andPassword password: String, _ completion: @escaping (Account?, Error?)->Void) {
        let originUrl = "https://localhost:8181/user/signup"
        let bodyDic = [
            "account": accountID,
            "password": password
        ]
        TNNetworkAPIRequest<Account>(originUrl, .post)
            .data(bodyDic)
            .start { (account,error) in
                if let account = account {
                    print("Register Success!")
                    self.account = account
                    completion(account,nil)
                } else {
                    print(error ?? "Unkonw error")
                    completion(nil,error)
                }
        }
    }
    
}
