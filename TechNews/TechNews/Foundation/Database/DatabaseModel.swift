//
//  DatabaseModel.swift
//  TechNews
//
//  Created by 金星 on 2020/4/4.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import PerfectCRUD

protocol DatabaseModel {
    
}

extension DatabaseModel where Self : Codable {
    
    static func query(on: DatabaseManager) -> Table<Self,DatabaseManager.DataBaseType>? {
        let table = DatabaseManager.default.migrationTable(for: self.self)
        return table
    }
    
}

extension Table {

}
