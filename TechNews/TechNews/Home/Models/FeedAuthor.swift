//
//  FeedAuthor.swift
//  TechNews
//
//  Created by 金星 on 2020/2/3.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

struct Author: Hashable, Codable, Identifiable ,DatabaseModel{
    var id: Int?
    var role: String?
    var avatarHd: String?
    var avatarLarge: String?
    var username: String
    
    
}
