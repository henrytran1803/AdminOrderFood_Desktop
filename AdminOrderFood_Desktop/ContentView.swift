//
//  ContentView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct ContentView: View {
    @State var isLogin = false
    var body: some View {
        VStack{
            if isLogin {
                HomeView(isLogin: $isLogin)
            }else {
                SignInView(isLogin: $isLogin)
            }
        }
        .onAppear{
            isLogin = UserDefaults.standard.bool(forKey: "isLogin")
            print(isLogin)
        }
    }
}

#Preview {
    ContentView()
}
