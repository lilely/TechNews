//
//  FeedSimpleModel.swift
//  TechNews
//
//  Created by 金星 on 2020/2/3.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

struct FeedSimpleModel: Hashable, Codable, Identifiable {
    
    var id: Int?
    var feed_id: String?
    var from: String
    var tag_name: String
    var original: String?
    var original_url: String?
    var title: String = ""
    var content: String?
    var author: Author?
    var created_at: String?
    var updated_at: String?
    
    static func == (lhs: FeedSimpleModel, rhs: FeedSimpleModel) -> Bool {
        guard let lhs_id = lhs.id, let rhs_id = rhs.id else {
            return false
        }
        guard let lhs_feedID = lhs.feed_id, let rhs_feedID = rhs.feed_id else {
            return false
        }
        return (lhs_id == rhs_id) && (lhs_feedID == rhs_feedID)
    }
    
    static func initFeedSimple(with dic: Dictionary<String, Any>)->FeedSimpleModel {
        let authorDic = dic["author"] as? Dictionary<String, Any>
        let author : Author?
        if let authorDic = authorDic{
            author = Author(id: authorDic["id"] as? Int,
                            role: authorDic["role"] as? String,
                            avatarHd: authorDic["avatarHd"] as? String,
                            avatarLarge: authorDic["avatarLarge"] as? String,
                            username: authorDic["username"] as? String ?? "no name")
        } else {
            author = nil
        }
        
        return FeedSimpleModel(id: dic["Id"] as? Int,
                               feed_id: dic["feedID"] as? String,
                               from: dic["from"] as? String ?? "no where",
                               tag_name: dic["tag_name"] as? String ?? "no tag",
                               original: dic["original"] as? String,
                               original_url: dic["original_url"] as? String,
                               title: dic["title"] as! String,
                               content: dic["content"] as? String,
                               author: author,
                               created_at: dic["created_at"] as? String,
                               updated_at: dic["updated_at"] as? String) }
    
}
