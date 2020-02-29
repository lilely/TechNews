//
//  HostProfileView.swift
//  TechNews
//
//  Created by 金星 on 2020/2/29.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct HostProfileView: View {
    
    @EnvironmentObject var profile: Profile
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                    .resizable()
                    .frame(width:100, height: 100)
                    .padding(EdgeInsets(top: 50, leading: 20, bottom: 5, trailing: 5))
                Spacer()
                VStack(alignment: .leading){
                    Text("My name")
                        .font(.system(size:25))
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 100))
                    Text("Description")
                        .font(.system(size:20))
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct HostProfileView_Previews: PreviewProvider {
    static var previews: some View {
        HostProfileView()
    }
}
