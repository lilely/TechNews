//
//  AbourtMeContentView.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct AbourtMeContentView: View {
    
    let group0ActionItems : [ProfileActionItem] = [ProfileActionItem(id: 0, icon: "message", title: "消息", descript: "进入消息"),
                                                   ProfileActionItem(id:1, icon: "list.dash", title: "消息", descript: "进入消息")]
    
    let group1ActionItems : [ProfileActionItem] = [ProfileActionItem(id: 0, icon: "flame", title: "设置", descript: "进入设置"),
    ProfileActionItem(id:1, icon: "gear", title: "设置", descript: "进入设置")]
    
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
            .navigationBarItems(trailing:NavigationLink(
                destination: LoginContentView().environmentObject(LoginData())

            ){
                Text("登录")
            })
        }
    }
}

struct AbourtMeContentView_Previews: PreviewProvider {
    static var previews: some View {
        AbourtMeContentView()
    }
}
