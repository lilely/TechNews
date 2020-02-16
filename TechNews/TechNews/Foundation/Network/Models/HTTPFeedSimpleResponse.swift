//
//  HTTPResponse.swift
//  TechNews
//
//  Created by 金星 on 2020/2/16.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

struct HTTPFeedSimpleResponse: Codable {
    let status: Int
    let message: String
    let data: [FeedSimpleModel]?
}
