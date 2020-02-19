//
//  FeedSearchResult.swift
//  TechNews
//
//  Created by 金星 on 2020/2/19.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

struct HTTPFeedSearchResponse: Codable {
    let status: Int
    let message: String
    let data: SearchResultModel?
}

struct SearchResultModel: Codable {
    let keyWord: String
    let userID: String
    let feeds: [FeedSimpleModel]?
}
