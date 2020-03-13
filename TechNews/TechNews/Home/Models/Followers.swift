//
//  FollowModel.swift
//  TechNews
//
//  Created by 金星 on 2020/3/5.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

struct Followers: Codable{
    var followAuthors : Set<String> = Set()
    var followAuthorIDs: Set<String> = Set()
}
