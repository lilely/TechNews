//
//  HTTPResponse.swift
//  TechNews
//
//  Created by 金星 on 2020/2/16.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

struct HTTPError: Error {
    
}

struct Empty: Codable{
    
}

struct HTTPResponse<T: Codable>: Codable {
    let status: Int
    let message: String
    let data: T?
    
}
