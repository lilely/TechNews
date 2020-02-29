//
//  HTTPResponse.swift
//  TechNews
//
//  Created by 金星 on 2020/2/16.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

struct HTTPResponse<T: Codable>: Codable {
    let status: Int
    let message: String
    let data: T?
}