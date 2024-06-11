//
//  HomeView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct HomeView: View {
    @State var currentTab = "Home"
    @Binding var isLogin: Bool
    var body: some View {
        HStack{
            SideMenu(currentTab: $currentTab, isLogin: $isLogin)
           
            if currentTab == "Home" {
                MainView()
            }else if currentTab == "Categories" {
                CategoryView()
            }else if currentTab == "Products" {
                ProductView()
            }else if currentTab == "Users" {
                UserView()
            }else if currentTab == "Orders" {
                OrderView()
            }
        }.frame(width: getRect().width / 1.3, height: getRect().height - 100 , alignment: .leading)
            .background(Color.white.ignoresSafeArea())
            .buttonStyle(PlainButtonStyle())
    }
}


extension View{
    func getRect() -> CGRect {
        return NSScreen.main!.visibleFrame
    }
}
