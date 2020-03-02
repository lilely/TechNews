//
//  ProfileActionRow.swift
//  TechNews
//
//  Created by 金星 on 2020/2/29.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct ProfileActionRow: View {
    var item: ProfileActionItem
    var body: some View {
        HStack {
            HStack {
                Image(systemName: item.icon)
                Text(item.title)
            }
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
            Spacer()
            Text(item.descript ?? "")
                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        }
    }
}

struct ProfileActionRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileActionRow(item: ProfileActionItem(icon: "person", title: "message", descript: "hello"))
    }
}
