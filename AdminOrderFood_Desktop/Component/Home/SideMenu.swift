//
//  SideMenu.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct SideMenu: View {
    @Binding var currentTab: String
    @Namespace var animation
    @Binding var isLogin : Bool
    var body: some View {
        VStack{
            HStack{
                Text("Order")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .kerning(1.5)
                Text("Food")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .kerning(1.5)
                    .padding(8)
                    .background(Color.green)
                    .cornerRadius(8)
            }
            .padding(10)
            Divider()
                .background(Color.gray.opacity(0.4))
                .padding(.bottom)
            Text("Welcome Admin!")
                .font(.title2)
                .bold()
                .foregroundStyle(.secondary)
            VStack{
                TabButton(image: "house", title: "Home", animation: animation, currentTab: $currentTab)
                TabButton(image: "archivebox", title: "Categories", animation: animation, currentTab: $currentTab)
                TabButton(image: "shippingbox", title: "Products", animation: animation, currentTab: $currentTab)
                TabButton(image: "person", title: "Users", animation: animation, currentTab: $currentTab)
                TabButton(image: "truck.box", title: "Orders", animation: animation, currentTab: $currentTab)
                Button(action:{
                    SignInViewModel().logOut()
                    isLogin = false
                }, label: {
                    HStack(spacing: 15){
                        Image(systemName:"infinity.circle" )
                            .font(.title2)
                            .foregroundColor( Color.blue )
                        Text("Logout")
                            .kerning(1.2)
                            .foregroundColor( Color.black )
                    }.padding(.leading, 5)
                })
                .padding(.vertical,12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .contentShape(Rectangle())
            }
            .padding(.leading, 20)
            .offset(x: 15)
            .padding(.top,20)
            Spacer()
        }.frame(width: 210)
        
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
}
struct TabButton :View {
    var image: String
    var title: String
    var animation: Namespace.ID
    @Binding var currentTab: String
    var body: some View {
        Button(action:{
            withAnimation{
            currentTab = title
            }
        }, label: {
            HStack(spacing: 15){
        
                Image(systemName:currentTab == title ? image : "\(image).fill" )
                    .font(.title2)
                    .foregroundColor(currentTab == title ?   Color.white : Color.blue )
                Text(title)
                    .kerning(1.2)
                    .foregroundColor(currentTab == title ?   Color.white : Color.black )
            }.padding(.leading, 5)
        })
        .padding(.vertical,12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(currentTab == title ? Color.blue :Color.white)
        .contentShape(Rectangle())
    }
}
