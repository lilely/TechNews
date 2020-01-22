//
//  HomeContentView.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct HomeContentView: View {
    @EnvironmentObject private var feedData: FeedDatas
    
    var body: some View {
//        NavigationView {
//            ZStack {
//                Color.red
//                NavigationLink {
//                    Text("123")
//                }
//            }
//       }.navigationBarTitle("Home").edgesIgnoringSafeArea(.all)
        
        NavigationView {
            List {
                ForEach(feedData.feeds) { feedModel in
                    NavigationLink(
                        destination: FollowContentView()
                    ) {
                        FeedContentRow(feedModel: feedModel)
                    }
                }
            }
            .navigationBarTitle("Home")
            .navigationBarItems(trailing: Button(action: {
                print("Tap")
            }, label: {
                Text("Right").foregroundColor(.orange)
            }))
        }
        
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView().environmentObject(FeedDatas())
    }
}
