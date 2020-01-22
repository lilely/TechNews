//
//  RootTabbarItem.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

final class RootTabbarItem {
    
    typealias resolveControllerBlock = ()->(UIViewController)
    
    var title: String!
    var image: String?
    var selectImage: String?
    var resolveControllerBlock : resolveControllerBlock!
    
    init(_ title: String,_ image: String?,_ selectImage: String?,_ resolveBlock: @escaping resolveControllerBlock) {
        self.title = title
        self.image = image
        self.selectImage = selectImage
        self.resolveControllerBlock = resolveBlock
    }
    
    convenience init(_ title: String,_ resolveBlock: @escaping resolveControllerBlock) {
        self.init(title, nil, nil, resolveBlock)
    }
    
}
