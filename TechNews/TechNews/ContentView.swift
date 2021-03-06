//
//  ContentView.swift
//  TechNews
//
//  Created by 金星 on 2020/1/21.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let accountData = AccountData()
    let feedsData = FeedSimpleData()
    let followFeedsData = FollowFeedsData()
    
    var body: some View {
        TabView {
            HomeContentView().environmentObject(feedsData).environmentObject(accountData).tabItem({
                Image(systemName: "square.stack.3d.down.right")
                Text("首页")
            }).tag(0)
            FollowContentView().environmentObject(accountData).environmentObject(followFeedsData)
                .tabItem({
                Image(systemName: "person.3")
                Text("关注")
            }).tag(1)
            
            SearchContentView().tabItem({
                Image(systemName: "magnifyingglass")
                Text("搜索")
            }).tag(2)
            
            RecommendPageView([RecommendContentView(),RecommendContentView()]).tabItem({
                Image(systemName: "paperplane")
                Text("新闻")
            }).tag(3)
            
            AbourtMeContentView().environmentObject(accountData)
                .tabItem({
                Image(systemName: "person")
                Text("我")
            }).tag(4)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}
