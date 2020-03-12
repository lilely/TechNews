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
    
    @Published var followers: Followers?
    
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
                    self.account?.username = accountID
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
                    self.account?.username = accountID
                    completion(account,nil)
                } else {
                    print(error ?? "Unkonw error")
                    completion(nil,error)
                }
        }
    }
    
    func isFollowed(author username: String?) -> Bool {
        guard let authorName = username else {
            return false
        }
        
        guard let followers = self.followers else {
            return false
        }
        for followerName in followers.followAuthors ?? [] {
            if authorName == followerName {
                return true
            }
        }
        return false
    }
    
    func fetchFollowers(_ completion: @escaping (Followers?, Error?)-> Void) {
        guard let username = self.account?.username else {
            completion(nil,nil)
            return
        }
        let originUrl = "https://localhost:8181/followers";
        let body = ["userID":username]
        TNNetworkAPIRequest<Followers>(originUrl, .post)
            .data(body)
            .start{ (followers,error) -> Void in
            if let followers = followers {
                print("fetch followers Success!")
                self.followers = followers
                completion(followers,nil)
            } else {
                print(error ?? "Unkonw error")
                completion(nil,error)
            }
        }
    }
}
