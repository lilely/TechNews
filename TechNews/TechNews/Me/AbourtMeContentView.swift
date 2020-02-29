//
//  AbourtMeContentView.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct AbourtMeContentView: View {
    
    var body: some View {
        NavigationView {
            Form {
                HostProfileView().environmentObject(Profile())
                Section {
                  Text("Abourt Me!")
                }
            }
            
            .navigationBarTitle(Text("个人信息"))
        }
    }
}

struct AbourtMeContentView_Previews: PreviewProvider {
    static var previews: some View {
        AbourtMeContentView()
    }
}
