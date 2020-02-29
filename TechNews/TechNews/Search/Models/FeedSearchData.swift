//
//  FeedSearchData.swift
//  TechNews
//
//  Created by 金星 on 2020/2/18.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Combine
import Foundation
import Alamofire

final class FeedSearchData: ObservableObject {
    
    @Published var searchResultFeedSimple : [FeedSimpleModel]?
    
    @Published var error: Error?

    func fetchSearchResultBy(keyword key:String) {
        let originUrl = "https://localhost:8181/search"
        let bodyDic = [
            "keyWord": key,
            "userID": "guoyingying07"
        ]
        TNNetworkAPIRequest<SearchResultModel>(originUrl, .get)
            .data(bodyDic)
            .start{ (searchResult,error) -> Void in
                if let error = error {
                    print(error)
                    self.error = error
                } else {
                    print("fetch feeds Success!")
                    self.searchResultFeedSimple = searchResult?.feeds
                }
        }
    }
}
