//
//  FeedSimpleData.swift
//  TechNews
//
//  Created by 金星 on 2020/2/3.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation
import Alamofire
import PerfectCRUD

struct FeedModel: Codable {
    var feedSimples: [FeedSimpleModel]
    var authors: [Author]
}

final class FeedSimpleData: ObservableObject {
    
    @Published var feedSimples: [FeedSimpleModel]?
    
    @Published var error : Error?
    
    func refreshFeedSimple() {
        let originUrl = "https://localhost:8181/feed_list/tag/推荐"
        do {
            self.feedSimples = try FeedSimpleModel.query(on: DatabaseManager.default)?
                                            .limit(20)
                                            .select()
                                            .map({$0})
        } catch {
            print(error)
        }
        TNNetworkAPIRequest<[FeedSimpleModel]>(originUrl, .get)
            .start{ (result) -> Void in
                switch result {
                case let .success(feedSimples):
                    self.feedSimples = feedSimples
                    do {
                        guard (feedSimples != nil) else {
                            return
                        }
                        try FeedSimpleModel.query(on: DatabaseManager.default)?.insert(feedSimples!)
                    } catch {
                        print(error)
                    }
                    break
                case let .failure(error):
                    self.error = error
                    break
                }
        }
    }
}
