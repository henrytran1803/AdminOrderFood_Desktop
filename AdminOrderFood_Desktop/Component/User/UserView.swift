//
//  UserView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct UserView: View {
    @State var isNew = false
    @State var isOpen = false
    @ObservedObject var model = UserViewModel()
    @State var userEdit  = User(id: 0, username: "", email: "", createDate: "", phone: "", address: "", roles: 0)
    var body: some View {
        VStack{
            HStack{
                Text("Users")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            VStack{
                if isOpen && isNew {
                    UserDetailView(isOpen: $isOpen ,isNew: $isNew, user:  User(id: 0, username: "", email: "", createDate: "", phone: "", address: "", roles: 0))
                        .onDisappear{
                            model.fetchAllUser{success in
                                
                            }
                        }
                }else if isOpen && !isNew{
                    UserDetailView(isOpen: $isOpen ,isNew: $isNew, user: userEdit)
                        .onDisappear{
                            model.fetchAllUser{success in
                                
                            }
                        }
                }else{
                    HStack{
                        Text("List User")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.secondary)
                        Spacer()
                        Button(action: {
                            isOpen = true
                            isNew = true
                        }, label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.blue)
                                .bold()
                        })
                    }.padding()
                    Divider()
                    List{
                        ForEach(model.users,id: \.id){ user in
                            HStack{
                                UserItemRow(user: user)
                                Button(action: {
                                    model.deleteUser(by: user.id){success in
                                        if success {
                                            print("xoá thành công")
                                        }else {
                                            print("xoá thất bại")
                                        }
                                    }
                                }, label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.pink)
                                        .font(.title)
                                })
                                Button(action: {
                                    isOpen = true
                                    userEdit = user
                                }, label: {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.yellow)
                                        .font(.title)
                                })
                            }
                            
                        }
                    }
                }
                
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .cornerRadius(10)
            .padding()
        }.frame(maxHeight: .infinity, alignment: .top)
            .background(Color.blue)
            .onAppear{
                model.fetchAllUser{success in
                    
                }
            }
    }
}

#Preview {
    UserView()
}
