//
//  LoginModel.swift
//  TechNews
//
//  Created by 金星 on 2020/2/28.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

struct Account : Codable, DatabaseModel{
    
    typealias Token = String
    
    var id: Int?
    var username: String
    var userID: String
    var accessToken: Token
    var expireTime: TimeInterval?
    var refreshToken: Token?
}
