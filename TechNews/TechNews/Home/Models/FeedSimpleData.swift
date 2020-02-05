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
    
    @Published var feedSimples = [FeedSimpleModel]()
    
    func refreshFeedSimple() {
        let originUrl = "https://localhost:8181/feed_list/tag/推荐"
        let charSet = NSMutableCharacterSet()
        charSet.formUnion(with: CharacterSet.urlQueryAllowed)
        charSet.addCharacters(in: "#")
        guard let encodingURL = originUrl.addingPercentEncoding(withAllowedCharacters: charSet as CharacterSet) else {
            return
        }
    
        guard let url = URL(string:encodingURL) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10 // 10 secs
        Alamofire.request(request).responseJSON {
            response in
            guard let data = response.data else {
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data , options: []) as? NSDictionary {
                    if case let status as Int = json["status"], status == 0 {
                        if case let feedArry as Array<NSDictionary> = json["data"] {
                            let feedModels =
                            feedArry.filter{
                                $0 is Dictionary<String, Any>
                            }.map {
                                FeedSimpleModel.initFeedSimple(with: $0 as! Dictionary<String, Any>)
                            }
                            DispatchQueue.main.async {
                                self.feedSimples = feedModels
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
