//
//  LoginModel.swift
//  TechNews
//
//  Created by 金星 on 2020/2/28.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

struct Account : Codable{
    
    typealias Token = String
    
    var username: String
    
    var accessToken: Token
    var expireTime: TimeInterval?
    var refreshToken: Token?
}
