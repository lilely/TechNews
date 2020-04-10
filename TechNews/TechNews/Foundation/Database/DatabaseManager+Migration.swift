//
//  DatabaseManager+Migration.swift
//  TechNews
//
//  Created by 金星 on 2020/4/4.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

extension DatabaseManager {
    
    static func setupModels() {
        DatabaseManager.default.addMigration(type: FeedSimpleAuthor.self)
        DatabaseManager.default.addMigration(type: Author.self)
        DatabaseManager.default.addMigration(type: FeedSimpleModel.self)
        DatabaseManager.default.addMigration(type: Followers.self)
        DatabaseManager.default.addMigration(type: Account.self)
    }
}
