//
//  RecommendPageViewController.swift
//  TechNews
//
//  Created by 金星 on 2020/5/1.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI
import UIKit

struct RecommendPageViewController: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIPageViewController
    
    @Binding var currentPage: Int
    
    var controllers: [UIViewController]
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<RecommendPageViewController>) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        return pageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: UIViewControllerRepresentableContext<RecommendPageViewController>) {
        uiViewController.setViewControllers([self.controllers[currentPage]], direction: .forward, animated: true)
    }
    
    func makeCoordinator() -> RecommendPageViewController.Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        var parent: RecommendPageViewController
        
        init(_ parent: RecommendPageViewController) {
            self.parent = parent
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = self.parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            
            if index == 0 {
                return self.parent.controllers.last
            }
            return self.parent.controllers[index-1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = self.parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index+1 == self.parent.controllers.count {
                return self.parent.controllers.first
            }
            return self.parent.controllers[index+1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
                let visibleViewController = pageViewController.viewControllers?.first,
                let index = parent.controllers.firstIndex(of: visibleViewController)
            {
                parent.currentPage = index
            }
        }
    }
    
}
