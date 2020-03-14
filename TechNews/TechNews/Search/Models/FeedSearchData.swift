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
        TNNetworkAPIRequest<SearchResultModel>(originUrl, .post)
            .data(bodyDic)
            .start{ (result) -> Void in
                switch result {
                case let .success(searchResult):
                    print("fetch feeds Success!")
                    self.searchResultFeedSimple = searchResult?.feeds
                    break
                case let .failure(error):
                    self.error = error
                    break
                default:
                    break
                }
        }
    }
}
