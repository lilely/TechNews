//
//  TNNetworkAPIMiddleware.swift
//  TechNews
//
//  Created by 金星 on 2020/4/12.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

public protocol TNNetworkAPIMiddleware {
    
    func respondTo<T: Codable>(_ req: TNNetworkAPIRequest<T>)
}

struct TNNetworkMiddlewareEntry{
    var type: Any.Type
    var maker: ()->TNNetworkAPIMiddleware
}

final class TNNetworkMiddlewareManager {
    
    static let `default` = TNNetworkMiddlewareManager()
    
    private(set) var middlewares: [TNNetworkMiddlewareEntry] = []
    
}

extension TNNetworkMiddlewareManager {
    
    func use<M>(middleWare: M) where M : TNNetworkAPIMiddleware{
        let entry = TNNetworkMiddlewareEntry(type: M.self, maker: {middleWare})
        self.middlewares.append(entry)
    }
    
    func unUse<M>(middleWare: M) where M : TNNetworkAPIMiddleware{
        guard let index = self.middlewares.firstIndex(where: {$0.type == M.self}) else {
            return
        }
        self.middlewares.remove(at: index)
    }
    
    func unUse<M>(type: M.Type) where M : TNNetworkAPIMiddleware {
        guard let index = self.middlewares.firstIndex(where: {$0.type == type}) else {
            return
        }
        self.middlewares.remove(at: index)
    }
    
    func removeAllMiddleWares() {
        self.middlewares.removeAll()
    }
}

extension TNNetworkMiddlewareManager: TNNetworkAPIMiddleware {
    
    func respondTo<T>(_ req: TNNetworkAPIRequest<T>) where T : Decodable, T : Encodable {
        self.middlewares.respondTo(req: req)
    }
}

extension Array where Element == TNNetworkMiddlewareEntry {
    func respondTo<T>(req: TNNetworkAPIRequest<T>) where T : Decodable, T : Encodable {
        _ = self.compactMap {
            $0.maker().respondTo(req)
        }
    }
}
