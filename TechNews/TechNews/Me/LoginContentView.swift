//
//  LoginContentView.swift
//  TechNews
//
//  Created by 金星 on 2020/2/26.
//  Copyright © 2020 com.corp.jinxing. All rights reserved.
//

import SwiftUI

struct LoginContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var accountData: AccountData
    @State private var inputAccountID = ""
    @State private var inputPassword = ""
    @State private var isRegister = true
    
    func isAccountValid() -> Bool {
        return self.inputAccountID.count >= 6
    }
    
    func isPasswordValid() -> Bool {
        return self.inputPassword.count >= 6
    }
    
    var body: some View {
        NavigationView {
        VStack {
            ZStack {
                TextField("输入账号",text:$inputAccountID, onEditingChanged: { isEditing in
                    
                }, onCommit: {
                    print("on commit")

                })
                .textContentType(.username)
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .frame(alignment:.center) .background(Color(.secondarySystemBackground))
                    .padding(EdgeInsets(top: 25, leading: 5, bottom: 25, trailing: 10))
                
                Button(action:{
                    
                }) {
                    Image(systemName: "person")
                }
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
                .offset(x:-(UIScreen.main.bounds.width-60-50)/2)
                
                if inputAccountID.count > 0 {
                    Button(action:{
                        self.inputAccountID = ""
                    }) {
                        Image(systemName: "xmark.circle")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 25))
                    .offset(x:(UIScreen.main.bounds.width-60-50)/2)
                }
            }
            .background(Color(.secondarySystemBackground))
            .frame(width:UIScreen.main.bounds.width-60)
            .cornerRadius(50.0)
            .padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 0))
            
            ZStack {
                
                TextField("输入密码",text:$inputPassword, onEditingChanged: { isEditing in
                    
                }, onCommit: {
                    print("on commit")

                })
                    .textContentType(.username)
                    .font(.system(size: 25))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(alignment:.center) .background(Color(.secondarySystemBackground))
                    .padding(EdgeInsets(top: 25, leading: 5, bottom: 25, trailing: 10))
                
                Button(action:{
                    
                }) {
                    Image(systemName: "eye")
                }
                .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
                .offset(x:-(UIScreen.main.bounds.width-60-50)/2)
                
                if inputPassword.count > 0 {
                    Button(action:{
                        self.inputPassword = ""
                    }) {
                        Image(systemName: "xmark.circle")
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 25))
                    .offset(x:(UIScreen.main.bounds.width-60-50)/2)
                }
            }
            .background(Color(.secondarySystemBackground))
            .frame(width:UIScreen.main.bounds.width-60)
            .cornerRadius(50.0)
            .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            
            Toggle(isOn: $isRegister) {
                if isRegister {
                    Text("注册")
                } else {
                    Text("登录")
                }
            }
            .frame(width:100)
            .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))

            Button(action: {
                if self.isRegister {
                    self.accountData.register(withAccount: self.inputAccountID, andPassword: self.inputPassword, { (account, error) -> Void in
                        self.presentationMode.wrappedValue.dismiss()
                    })
                } else {
                    self.accountData.login(withAccount: self.inputAccountID, andPassword: self.inputPassword, { (account, error) -> Void in
                        self.presentationMode.wrappedValue.dismiss()
                    })
                }
            }) {
                Image(systemName: "chevron.right.circle")
                .resizable()
                .frame(width:50, height:50)
            }
            .disabled(!self.isAccountValid() || !self.isPasswordValid())
            .padding(EdgeInsets(top: 150, leading: 0, bottom: 0, trailing: 0))
            
            Spacer()
        }.resignKeyboardOnDragGesture()
    }
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
