//
//  AbourtMeContentView.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct AbourtMeContentView: View {
    @EnvironmentObject private var accountData: AccountData
    @State private var gotoLogin: Bool = false
    
    let group0ActionItems : [ProfileActionItem] = [ProfileActionItem(id: 0, icon: "message", title: "消息", descript: "进入消息"),
                                                   ProfileActionItem(id:1, icon: "list.dash", title: "消息", descript: "进入消息")]
    
    let group1ActionItems : [ProfileActionItem] = [ProfileActionItem(id: 0, icon: "flame", title: "设置", descript: "进入设置"),
    ProfileActionItem(id:1, icon: "gear", title: "设置", descript: "进入设置")]
    
    func refreshProfile() {
        self.accountData.fetchLocalAccount { _,_ in 
            ()
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                HostProfileView().environmentObject(Profile())
                ForEach(group0ActionItems) { actionItem in
                    ProfileActionRow(item: actionItem)
                }
                Section {
                    ForEach(group1ActionItems) { actionItem in
                        ProfileActionRow(item: actionItem)
                    }
                }
            }
            .navigationBarTitle(Text("个人信息"))
            .navigationBarItems(trailing:
                HStack {
                    if self.accountData.account == nil {
                        Button(action: {
                            self.gotoLogin = true
                        }) {
                            Text("登录/注册")
                        }.sheet(isPresented: self.$gotoLogin) {
                            LoginContentView().environmentObject(self.accountData)
                        }
                        
                    } else {
                        Button(action: {
                            
                        }) {
                            Text("已登录")
                        }
                    }
            })
        }.onAppear(perform: self.refreshProfile)
    }
}

struct AbourtMeContentView_Previews: PreviewProvider {
    static var previews: some View {
        AbourtMeContentView()
    }
}
