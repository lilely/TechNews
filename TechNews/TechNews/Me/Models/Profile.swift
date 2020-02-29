//
//  Profile.swift
//  TechNews
//
//  Created by 金星 on 2020/2/29.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import Foundation

class Profile: ObservableObject {
    @Published var portrait: URL?
    @Published var username: String?
    @Published var phoneNumber: String?
    @Published var gender: Gender = .Undefine
    
    enum Gender: String, CaseIterable {
        case Male = "Male"
        case Female = "Female"
        case Undefine = "Undefine"
    }
}
