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

    func fetchSearchResultBy(keyword key:String) {
        let originUrl = "https://localhost:8181/search"
        let charSet = NSMutableCharacterSet()
        charSet.formUnion(with: CharacterSet.urlQueryAllowed)
        charSet.addCharacters(in: "#")
        guard let encodingURL = originUrl.addingPercentEncoding(withAllowedCharacters: charSet as CharacterSet) else {
            return
        }
        guard let url = URL(string:encodingURL) else {
            return
        }
        let bodyDic = [
            "keyWord": key,
            "userID": "guoyingying07"
        ]
        let headers = [
            "Content-Type": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: bodyDic, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { (response) in
            guard let data = response.data else {
                return
            }
            if let response = try? JSONDecoder().decode(HTTPFeedSearchResponse.self,from:data ) {
                if let searchResult = response.data {
                    DispatchQueue.main.async {
                        self.searchResultFeedSimple = searchResult.feeds
                    }
                }
            }
        }
    }
}
