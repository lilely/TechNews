//
//  RootTabbarViewController.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import UIKit
import SwiftUI

class RootTabbarViewController: UITabBarController {
    
    var tabbarItems: [RootTabbarItem]
    
    init(items tabbarItems: [RootTabbarItem]) {
        self.tabbarItems = tabbarItems
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.tabbarItems = []
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabbars()
    }
    
    func setupTabbars() {
        self.viewControllers =
        self.tabbarItems.map { (tabbarItem) -> UIViewController in
            let image: UIImage?
            let selectImage: UIImage?
            if let imageName = tabbarItem.image {
                image = UIImage.init(named: imageName)
            } else {
                image = nil
            }
            if let SelectImageName = tabbarItem.selectImage {
                selectImage = UIImage.init(named: SelectImageName)
            } else {
                selectImage = nil
            }
            
            let controller = tabbarItem.resolveControllerBlock()
            controller.tabBarItem = UITabBarItem(title: tabbarItem.title, image: image, selectedImage: selectImage)
            return controller
        }
    }
}

