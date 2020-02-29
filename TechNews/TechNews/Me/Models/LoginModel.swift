//
//  LoginModel.swift
//  TechNews
//
//  Created by 金星 on 2020/2/28.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

struct LoginModel : Codable{
    
    typealias Token = String
    
    var accessToken: Token
    var expireTime: TimeInterval?
    var refreshToken: Token?
}

struct HTTPLoginModelResponse: Codable {
    let status: Int
    let message: String
    let data: LoginModel
}
