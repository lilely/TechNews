//
//  FollowContentView.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh

struct FollowContentView: View {
    @EnvironmentObject private var accountData: AccountData
    @EnvironmentObject private var followFeeds: FollowFeedsData
    @State private var isShowing: Bool = false
    @State private var gotoLogin: Bool = false
    
    func refresh() {
        guard let userID = self.accountData.account?.userID else {
            return
        }
        self.followFeeds.refreshFollowFeedsSimple(userID: userID)
    }
    
    var body: some View {
        NavigationView {
            VStack{
                if self.accountData.account != nil {
                    List(self.followFeeds.feeds) {
                        feedSimple in
                        NavigationLink(
                            destination: FeedDetailView()
                        ) {
                            FeedContentRow(accountData: self.accountData, feedModel: feedSimple)
                        }
                    }
                } else {
                    Button(action: {
                        self.gotoLogin = true
                    }) {
                        Text("登录/注册")
                    }.sheet(isPresented: self.$gotoLogin) {
                        LoginContentView().environmentObject(self.accountData)
                    }
                }
            }
            .pullToRefresh(isShowing: $isShowing, onRefresh: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.isShowing = false
                }
                self.refresh()
            })
            .navigationBarTitle(Text("关注"))
            .navigationBarItems(trailing: Button(action: {
                print("Tap")
                self.accountData.fetchFollowers { _,_ in
                    
                }
            }, label: {
                Text("Right").foregroundColor(.orange)
            }))
            .onAppear(perform: refresh)
        }
    }
}

struct FollowContentView_Previews: PreviewProvider {
    static var previews: some View {
        FollowContentView().environmentObject(FollowFeedsData()).environmentObject(AccountData())
    }
}
