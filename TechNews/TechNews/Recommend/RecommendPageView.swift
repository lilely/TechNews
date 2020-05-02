//
//  RecommendPageView.swift
//  TechNews
//
//  Created by 金星 on 2020/5/1.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct RecommendPageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    
    @State var currentPage: Int = 0
    
    init(_ views: [Page]) {
        self.viewControllers = views.map{ UIHostingController(rootView: $0) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                RecommendPageViewController(currentPage: $currentPage, controllers: self.viewControllers)
                RecommendPageControl(numberOfPages: self.viewControllers.count, currentPage: $currentPage)
            }
           .navigationBarTitle(Text("新闻"))
        }
    }
}

struct RecommendPageView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendPageView([RecommendContentView()])
    }
}
