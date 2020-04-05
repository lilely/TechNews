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
    
    private let dataBase: Database<SQLiteDatabaseConfiguration>
    
    static let `default` = DatabaseManager()
    
    init() {
        let docPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dbPath = docPaths[0].path+"/2020-jx-db"
        dataBase = Database(configuration: try! SQLiteDatabaseConfiguration(dbPath))
    }
    
    public func addMigration<T: Codable>(type: T.Type) {
        do {
            try self.dataBase.create(type)
        } catch {
            print(error)
        }
        
        let table = self.dataBase.table(type)
        if let index = self.migrations.firstIndex(where:{ ($0 as? TableEntry<T>)?.entryType == type }) {
            self.migrations[index] = TableEntry(entryType: type, table: table)
        } else {
            self.migrations.append(TableEntry(entryType: type, table: table))
        }
        
    }
    
    public func migrationTable<T: Codable>(for type: T.Type) -> Table<T,DataBaseType>? {
        guard let index = self.migrations.firstIndex(where:{ ($0 as? TableEntry<T>)?.entryType == type}) else {
            return nil
        }
        return (self.migrations[index] as? TableEntry<T>)?.table
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
