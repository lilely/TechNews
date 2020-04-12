//
//  AuthenticateNetworkMiddleware.swift
//  TechNews
//
//  Created by 金星 on 2020/4/12.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

struct AuthenticateNetworkMiddleware: TNNetworkAPIMiddleware {
    
    private(set) var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    func respondTo<T>(_ req: TNNetworkAPIRequest<T>) where T : Decodable, T : Encodable {
        req.headers["Authentication"] = account.accessToken
    }
}
