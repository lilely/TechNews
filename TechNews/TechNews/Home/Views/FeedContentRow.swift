//
//  FeedContentRow.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct FeedContentRow: View {
    var feedModel: FeedSimpleModel
    var body: some View {
        HStack {
            Text("\(feedModel.title)")
                .padding()
            Spacer()
            Text("\(feedModel.author?.username ?? "noname")")
                .padding()
        }
        
    }
}

struct FeedContentRow_Previews: PreviewProvider {
    static var previews: some View {
        let author = Author(id: 1, role: "Guest", avatarHd: "", avatarLarge: "", username: "haha侠")
        let feedModel: FeedSimpleModel = FeedSimpleModel(id: 1, feed_id: "1", from: "juejin", tag_name: "推荐", original: "", original_url: "", title: "吃饭", author: author, created_at: "111", updated_at: "222")
        return FeedContentRow(feedModel: feedModel)
    }
}
