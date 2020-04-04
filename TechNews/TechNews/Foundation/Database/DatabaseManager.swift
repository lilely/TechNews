//
//  Database.swift
//  TechNews
//
//  Created by 金星 on 2020/4/4.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation
import PerfectCRUD
import PerfectSQLite

final class DatabaseManager {
    
    typealias DataBaseType = Database<SQLiteDatabaseConfiguration>
    
    struct TableEntry<T: Codable>: TableEntryProtocol {
        
        typealias ElementType = T
        
        var entryType: T.Type
        
        var table: Table<T, DataBaseType>
        
    }
    
    var migrations: [Any] = []
    
    private let dataBase: Database = Database(configuration: try! SQLiteDatabaseConfiguration("TechNews"))
    
    static let `default` = DatabaseManager()
    
    public func addMigration<T: Codable>(type: T.Type) {
        let table = self.dataBase.table(type)
        if let index = self.migrations.firstIndex(where:{ ($0 as? TableEntry<T>)?.entryType == type }) {
            self.migrations[index] = table
        } else {
            self.migrations.append(table)
        }
        self.migrations.append(TableEntry(entryType: type, table: table))
    }
    
    public func migrationTable<T: Codable>(for model: T) -> Table<T,DataBaseType>? {
        guard let index = self.migrations.firstIndex(where:{ ($0 as? TableEntry<T>)?.entryType == T.Type.self}) else {
            return nil
        }
        return self.migrations[index] as? Table<T, DataBaseType>
    }
}

protocol TableEntryProtocol {
    
    associatedtype ElementType: Codable
    
    var entryType: ElementType.Type { get }
    
    var table: Table<ElementType,DatabaseManager.DataBaseType> { get }
}
