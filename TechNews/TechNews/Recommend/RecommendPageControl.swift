//
//  RecommendPageControl.swift
//  TechNews
//
//  Created by 金星 on 2020/5/2.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI
import UIKit

struct RecommendPageControl: UIViewRepresentable {
    
    typealias UIViewType = UIPageControl
    
    var numberOfPages: Int
    
    @Binding var currentPage: Int
    
    func makeUIView(context: UIViewRepresentableContext<RecommendPageControl>) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.addTarget(context, action: #selector(coordinator.updateCurrentPage(sender:)), for: .valueChanged)
        
        return pageControl
    }
    
    func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<RecommendPageControl>) {
        uiView.currentPage = currentPage
    }
    
    class coordinator: NSObject {
        var control: RecommendPageControl
        
        init(_ pageControl: RecommendPageControl) {
            self.control = pageControl
        }
        
        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
    
}
