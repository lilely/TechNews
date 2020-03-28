//
//  FollowFeedsData.swift
//  TechNews
//
//  Created by 金星 on 2020/3/28.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Combine

final class FollowFeedsData: ObservableObject {
    @Published private(set) var feeds: [FeedSimpleModel] = []
    
    func refreshFollowFeedsSimple(userID: String) {
        let url = "https://localhost:8181/feed_list/follow/" + userID
        TNNetworkAPIRequest<[FeedSimpleModel]>.init(url, .get)
            .start { result in
                switch result {
                case .success(let feeds):
                    if feeds != nil {
                        self.feeds = feeds!
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}
