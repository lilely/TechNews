//
//  SearchFeedRow.swift
//  TechNews
//
//  Created by 金星 on 2020/2/19.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct SearchFeedRow: View {
    var feedModel: FeedSimpleModel
    var avatarUrl: URL? {
        if let hd_url = self.feedModel.author?.avatarHd {
            return URL(string:hd_url)
        } else if let large_url = self.feedModel.author?.avatarLarge {
            return URL(string:large_url)
        } else {
            return nil
        }
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(self.feedModel.title)")
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5))
                .font(.headline)
                Text("转自:\(self.feedModel.from_station)")
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5))
            }
            Spacer()
            VStack(alignment: .trailing) {
                KFImage(self.avatarUrl).placeholder {
                    HStack {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    .foregroundColor(.gray)
                }
                .resizable()
                .frame(width: 25, height: 25)
                .cornerRadius(25)
                .shadow(radius: 1.5)
                .padding(EdgeInsets(top: 15, leading: 0, bottom: 2.5, trailing: 5))
                Text("\(self.feedModel.author?.username ?? "未知")")
                    .padding(EdgeInsets(top: 2.5, leading: 0, bottom: 10, trailing: 5))
            }
        }
    }
}

struct SearchFeedRow_Previews: PreviewProvider {
    static var previews: some View {
        let author = Author(id: 1, role: "Guest", avatarHd: "", avatarLarge: "", username: "haha侠")
        let feedModel: FeedSimpleModel = FeedSimpleModel(id: 1, feedID: "1", from_station: "juejin", tag_name: "推荐", original: "", original_url: "", title: "吃饭", content:"blablabla",author: author, created_at: "111", updated_at: "222")
        return SearchFeedRow(feedModel: feedModel)
    }
}
