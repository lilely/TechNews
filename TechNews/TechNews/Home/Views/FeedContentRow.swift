//
//  FeedContentRow.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct FeedContentRow: View {
    var feedModel: FeedModel
    var body: some View {
        HStack {
            Text("\(feedModel.name)")
                .padding()
            Spacer()
            Text("\(feedModel.description)")
                .padding()
        }
        
    }
}

struct FeedContentRow_Previews: PreviewProvider {
    static var previews: some View {
        let feedModel: FeedModel = FeedModel(id: 1, name: "123", description: "321")
        return FeedContentRow(feedModel: feedModel)
    }
}
