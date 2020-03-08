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
    
    var accountData: AccountData
    
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
    
    var isFollowed: Bool {
        return self.accountData.isFollowed(author: self.feedModel.author?.username)
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
                    .frame(width: 50, height: 50)
                    .cornerRadius(25)
                    .shadow(radius: 2.5)
                    Text("\(feedModel.author?.username ?? "noname")")
                    .font(.headline)
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    Spacer()
                    if (self.accountData.account != nil) {
                        Button(action:{
                            print("123123123123123123")
                        }){
                            if self.isFollowed {
                                Text("取消关注")
                            } else {
                                Text("关注")
                            }
                        }
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .background(Color.orange)
                        .cornerRadius(7)
                        .buttonStyle(BorderlessButtonStyle())
                    }
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
        let feedModel: FeedSimpleModel = FeedSimpleModel(id: 1, feedID: "1", from: "juejin", tag_name: "推荐", original: "", original_url: "", title: "吃饭", content:"blablabla",author: author, created_at: "111", updated_at: "222")
        return FeedContentRow(accountData: AccountData(), feedModel: feedModel)
    }
}
