//
//  LoginData.swift
//  TechNews
//
//  Created by 金星 on 2020/2/28.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation
import PerfectCRUD

final class AccountData: ObservableObject {
    
    @Published var account: Account?
    
    @Published var followers: Followers = Followers()
    
    func fetchLocalAccount(on completion: @escaping (Account?, Error?)->Void) {
        do {
            self.account = try Account.query(on: DatabaseManager.default)?
                                            .limit(1)
                                            .select()
                                            .map({$0})
                                            .first
        } catch {
            print(error)
        }
        if self.account != nil {
            completion(self.account,nil)
        }
    }
    
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
                        self.setupAuthentication()
                        do {
                            try Account.query(on: DatabaseManager.default)?
                                            .insert(account)
                        } catch {
                            print(error)
                        }
                        completion(account,nil)
                        self.fetchFollowers { (followers, error) in
                            if let followers = followers {
                                self.followers = followers
                                do {
                                    try Followers.query(on: DatabaseManager.default)?
                                        .insert([followers])
                                } catch {
                                    print(error)
                                }
                            } else {
                                print(error ?? "Unkonw error")
                            }
                        }
                    }
                
                    break;
                case let .failure(error):
                    completion(nil,error)
                
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
                        self.setupAuthentication();
                        print("Register Success!")
                        self.account = account
                        completion(account,nil)
                    }
                    
                    break;
                case let .failure(error):
                    completion(nil,error)
                    break;
                }
            }
    }
}

extension AccountData {
    
    func setupAuthentication() {
        guard self.account != nil else {
            return
        }
        let autenticationMiddleware = AuthenticateNetworkMiddleware(account: self.account!)
        TNNetworkMiddlewareManager.default.use(middleWare: autenticationMiddleware)
    }
    
    func unInstallAuthentication() {
        TNNetworkMiddlewareManager.default.unUse(type: AuthenticateNetworkMiddleware.self)
    }
}

extension AccountData {
    
    func isFollowed(author username: String?) -> Bool {
        guard let authorName = username else {
            return false
        }

        for followerName in followers.followAuthors {
            if authorName == followerName {
                return true
            }
        }
        return false
    }
    
    func fetchFollowers(_ completion: @escaping (Followers?, Error?)-> Void) {
        guard let userID = self.account?.userID else {
            completion(nil,nil)
            return
        }
        let originUrl = "https://localhost:8181/follow/followers/\(userID)";
        TNNetworkAPIRequest<Followers>(originUrl, .get)
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
                }
        }
    }
    
    func startFollow(author authorName: String,_ completion: @escaping (Error?)-> Void) {
        guard let userID = self.account?.userID else {
            completion(nil)
            return
        }
        let originUrl = "https://localhost:8181/follow/author";
        let body = ["userID":userID,
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
                }
        }
    }
    
    func unFollow(author authorName: String,_ completion: @escaping (Error?)-> Void) {
        guard let userID = self.account?.userID else {
            completion(nil)
            return
        }
        let originUrl = "https://localhost:8181/unfollow/author";
        let body = ["userID":userID,
                    "followAuthors":[authorName]] as [String : Any]
        TNNetworkAPIRequest<Empty>(originUrl, .post)
            .data(body)
            .start{ (result) -> Void in
                switch result {
                case .success(_):
                    self.followers.followAuthors.remove(authorName)
                    print("post followers Success!")
                    completion(nil)
                    break
                case let .failure(error):
                    print(error)
                    completion(error)
                    break
                }
        }
    }
}
