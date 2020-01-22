//
//  FeedModel.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct FeedModel: Hashable, Codable, Identifiable {
    
    var id: Int
    var name: String
    var description: String
    
}
