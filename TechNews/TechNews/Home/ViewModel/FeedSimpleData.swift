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
        TNNetworkAPIRequest<[FeedSimpleModel]>(originUrl, .get)
            .start{ (result) -> Void in
                switch result {
                case let .success(feedSimples):
                    self.feedSimples = feedSimples
                    guard let table0 = FeedSimpleAuthor.query(on: DatabaseManager.default) else {
                        return
                    }
                    do {
                        guard (feedSimples != nil) else {
                            return
                        }
                        let feedSimpleAuthors =
                        feedSimples?.compactMap({ (feedSimple) -> FeedSimpleAuthor? in
                            return FeedSimpleAuthor(authorID: feedSimple.author?.id ?? -1, feedSimpleID: feedSimple.id ?? -1)
                        })
                        if feedSimpleAuthors != nil {
                            try table0.insert(feedSimpleAuthors!)
                        }
                    } catch {
                        print(error)
                    }
                    
                    
                    guard let table1 = FeedSimpleModel.query(on: DatabaseManager.default) else {
                        return
                    }
                    do {
                        guard (feedSimples != nil) else {
                            return
                        }
                        try table1.insert(feedSimples!)
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
