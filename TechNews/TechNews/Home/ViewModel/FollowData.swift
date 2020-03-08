//
//  FollowData.swift
//  TechNews
//
//  Created by 金星 on 2020/3/5.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

final class FollowData: ObservableObject{
    @Published var followers: Followers?
    
    func fetchFolloers(_ userID: String,_ completion: @escaping (Followers?, Error?)-> Void) {
        let originUrl = "https://localhost:8181/followers";
        let body = ["userID":userID]
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
