//
//  FeedContentRow.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct FeedContentRow: View {
    var feedModel: FeedSimpleModel
    
    var avatarUrl: URL {
        if let hd_url = self.feedModel.author?.avatarHd {
            return URL(string:hd_url)!
        } else if let large_url = self.feedModel.author?.avatarLarge {
            return URL(string:large_url)!
        } else {
            return URL(string:"123")!
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    KFImage(self.avatarUrl).placeholder {
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        .foregroundColor(.gray)
                    }
                    .resizable()
                    .shadow(radius: 25)
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                    Text("\(feedModel.author?.username ?? "noname")")
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    
                }
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5))
                Text("\(feedModel.title)")
                .font(.headline)
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                Text("\(feedModel.content ?? "")")
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5))
            }
            Spacer()
        }
        
    }
}

struct FeedContentRow_Previews: PreviewProvider {
    static var previews: some View {
        let author = Author(id: 1, role: "Guest", avatarHd: "", avatarLarge: "", username: "haha侠")
        let feedModel: FeedSimpleModel = FeedSimpleModel(id: 1, feed_id: "1", from: "juejin", tag_name: "推荐", original: "", original_url: "", title: "吃饭", content:"blablabla",author: author, created_at: "111", updated_at: "222")
        return FeedContentRow(feedModel: feedModel)
    }
}
