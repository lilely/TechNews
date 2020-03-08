//
//  FeedSimpleData.swift
//  TechNews
//
//  Created by 金星 on 2020/2/3.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation
import Alamofire

final class FeedSimpleData: ObservableObject {
    
    @Published var feedSimples: [FeedSimpleModel]?
    
    @Published var error : Error?
    
    func refreshFeedSimple() {
        let originUrl = "https://localhost:8181/feed_list/tag/推荐"
        TNNetworkAPIRequest<[FeedSimpleModel]>(originUrl, .get)
            .start{ (feedSimples,error) -> Void in
                if let error = error {
                    print(error)
                    self.error = error
                } else {
                    print("fetch feeds Success!")
                    self.feedSimples = feedSimples
                }
        }
    }
}