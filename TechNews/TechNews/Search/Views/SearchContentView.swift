//
//  SearchContentView.swift
//  TechNews
//
//  Created by 星金 on 2020/1/22.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI
import Combine

struct SearchContentView: View {
    @ObservedObject var searchData = FeedSearchData()
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    init() {
        self.searchData.fetchSearchResultBy(keyword: "推荐")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("输入标签名",text:$searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("on commit")
                            self.searchData.fetchSearchResultBy(keyword: self.searchText)
                        }).foregroundColor(.primary)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                        
                    if showCancelButton {
                        Button("取消") {
                            UIApplication.shared.endEditing(true)
                            self.searchData.fetchSearchResultBy(keyword: "推荐")
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(self.showCancelButton)
                if self.searchData.searchResultFeedSimple != nil {
                    List(self.searchData.searchResultFeedSimple ?? []) {
                        feedSimple in
                        NavigationLink(
                            destination: FeedDetailView()
                        ) {
                            SearchFeedRow(feedModel: feedSimple)
                        }
                    }
                } else {
                    Spacer()
                }
            }
            .navigationBarTitle(Text("搜索"))
            .resignKeyboardOnDragGesture()
            .onAppear(perform: {
                self.searchData.fetchSearchResultBy(keyword: "推荐")
            })
        }
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

struct SearchContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchContentView()
    }
}
