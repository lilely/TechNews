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
            HomeContentView().environmentObject(FeedSimpleData()).tabItem({
                Image(systemName: "123")
                Text("首页")
            }).tag(0)
            
            FollowContentView().tabItem({
                Image(systemName: "321")
                Text("关注")
            }).tag(1)
            
            RecommendContentView().tabItem({
                Image(systemName: "1213")
                Text("推荐")
            }).tag(2)
            
            AbourtMeContentView().tabItem({
                Image(systemName: "333")
                Text("我")
            }).tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return ContentView()
    }
}
