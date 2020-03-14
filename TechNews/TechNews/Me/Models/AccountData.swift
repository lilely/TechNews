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
    
    @Published var followers: Followers = Followers()
    
    func login(withAccount accountID: String,andPassword password: String,_ completion: @escaping (Account?, Error?)->Void) {
        
        let originUrl = "https://localhost:8181/user/signin"
        let bodyDic = [
            "account": accountID,
            "password": password
        ]
        TNNetworkAPIRequest<Account>(originUrl, .post)
            .data(bodyDic)
            .start{ (result) -> Void in
                switch result {
                case let .success(account):
                    if let account = account {
                        print("Login Success!")
                        self.account = account
                        completion(account,nil)
                    }
                
                    break;
                case let .failure(error):
                    completion(nil,error)
                
                    break;
                default:
                    break;
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
            .start { (result) -> Void in
                switch result {
                case let .success(account):
                    if let account = account {
                        print("Register Success!")
                        self.account = account
                        completion(account,nil)
                    }
                    
                    break;
                case let .failure(error):
                    completion(nil,error)
                    break;
                default:
                    break;
                }
            }
    }
    
    func isFollowed(author username: String?) -> Bool {
        guard let authorName = username else {
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
            .start{ (result) -> Void in
                switch result {
                case let .success(followers):
                    guard (followers != nil) else {
                        completion(nil,nil)
                        return
                    }
                    self.followers = followers!
                    completion(followers,nil)
                    break
                case let .failure(error):
                    print(error)
                    completion(nil,error)
                    break
                default:
                    break
                }
        }
    }
    
    func startFollow(author authorName: String,_ completion: @escaping (Error?)-> Void) {
        guard let username = self.account?.username else {
            completion(nil)
            return
        }
        let originUrl = "https://localhost:8181/follow/author";
        let body = ["userID":username,
                    "followAuthors":[authorName]] as [String : Any]
        TNNetworkAPIRequest<Empty>(originUrl, .post)
            .data(body)
            .start{ (result) -> Void in
                switch result {
                case .success(_):
                    self.followers.followAuthors.insert(authorName)
                    print("post followers Success!")
                    completion(nil)
                    break
                case let .failure(error):
                    print(error)
                    completion(error)
                    break
                default:
                    break
                }
        }
    }
}
