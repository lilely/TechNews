//
//  HomeContentView.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct HomeContentView: View {
    @EnvironmentObject private var feedData: FeedSimpleData
    
    var body: some View {  
        NavigationView {
            List {
                ForEach(self.feedData.feedSimples) { feedSimple in
                    NavigationLink(
                        destination: FollowContentView()
                    ) {
                        FeedContentRow(feedModel: feedSimple)
                    }
                }
            }
            .navigationBarTitle("Home")
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
