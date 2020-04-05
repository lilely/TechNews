//
//  RecommendContentView.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct RecommendContentView: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Recommend!")
            }
           .navigationBarTitle(Text("新闻"))
        }
    }
}

struct RecommendContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendContentView()
    }
}
