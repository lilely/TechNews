//
//  HomeContentView.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh

struct HomeContentView: View {
    @EnvironmentObject private var feedData: FeedSimpleData
    @EnvironmentObject private var accountData: AccountData
    @State private var isShowing = false
    
    init() {
        UINavigationBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        NavigationView {
            if self.feedData.feedSimples?.count ?? 0 > 0 {
                List(self.feedData.feedSimples ?? []) {
                    feedSimple in
                    NavigationLink(
                        destination: FeedDetailView()
                    ) {
                        FeedContentRow(accountData: self.accountData, feedModel: feedSimple)
                    }
                }
                .pullToRefresh(isShowing: $isShowing, onRefresh: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isShowing = false
                    }
                    self.refresh()
                })
                .navigationBarTitle(Text("首页"))
                .navigationBarItems(trailing: Button(action: {
                    print("Tap")
                    self.accountData.fetchFollowers { _,_ in
                        
                    }
                }, label: {
                    Text("Right").foregroundColor(.orange)
                }))
            } else {
                Text("Empty")
            }
        }.onAppear(perform: refresh)
    }
    
    func refresh() {
        self.feedData.refreshFeedSimple()
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView().environmentObject(FeedSimpleData())
    }
}
