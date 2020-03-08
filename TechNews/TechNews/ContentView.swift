//
//  ContentView.swift
//  TechNews
//
//  Created by 金星 on 2020/1/21.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            HomeContentView().environmentObject(FeedSimpleData()).environmentObject(FollowData()).tabItem({
                Image(systemName: "square.stack.3d.down.right")
                Text("首页")
            }).tag(0)
            
            FollowContentView().tabItem({
                Image(systemName: "person.3")
                Text("关注")
            }).tag(1)
            
            SearchContentView().tabItem({
                Image(systemName: "magnifyingglass")
                Text("搜索")
            }).tag(2)
            
            RecommendContentView().tabItem({
                Image(systemName: "paperplane")
                Text("新闻")
            }).tag(3)
            
            AbourtMeContentView()
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
