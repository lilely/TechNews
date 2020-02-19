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
    @State private var isShowing = false
    init() {
        UINavigationBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        NavigationView {
            List(self.feedData.feedSimples) {
                feedSimple in
                NavigationLink(
                    destination: FeedDetailView()
                ) {
                    FeedContentRow(feedModel: feedSimple)
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
            }, label: {
                Text("Right").foregroundColor(.orange)
            }))
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
