//
//  UserDetailView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI
//{
//    "username": "username123",
//    "email": "emai123@gmail.com",
//    "password": "123456",
//    "phone": "+84 blabla",
//    "address": "address"
//}
enum Role: Int, Codable, CaseIterable, Identifiable {
    case admin = 1
    case user = 2

    var id: Int { self.rawValue }

    var description: String {
        switch self {
        case .admin:
            return "Admin"
        case .user:
            return "User"
        }
    }
}
struct UserDetailView: View {
    @Binding var isOpen: Bool
    @Binding var isNew : Bool
    @State var user: User
    @State var pass : String = ""
    @State private var selection: Role = .user
    @ObservedObject var model = UserViewModel()
    @ObservedObject var modelCreate = SignUpViewModel()
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
            
            VStack(alignment: .leading){
                HStack{
                    Text(isNew ? "Edit user" :"Add new user")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.secondary)
                    Spacer()
                }.padding()
                Divider()
                TextFieldView(name: "username", textInput: $user.username)
                TextFieldView(name: "email", textInput: $user.email)
                TextFieldView(name: "address", textInput: $user.address)
                TextFieldView(name: "phone", textInput: $user.phone)
                if isNew {
                    TextFieldView(name: "Password", textInput: $pass)
                }
                Picker("Select a role", selection: $selection) {
                    ForEach(Role.allCases) { role in
                        Text(role.description).tag(role)
                    }
                }
                .pickerStyle(.inline)
                //                TextFieldView(name: "roles", textInput: "\($user.roles)")
                HStack{
                    
                    Button(action: {
                        if isNew {
                            modelCreate.signup = SignUp(username: user.username, email: user.email, password: pass, phone: user.phone, address: user.address)
                            modelCreate.signUpUser(){success,arg  in
                                if success {
                                    isOpen = false
                                    isNew = false
                                    print("thêm thành công")
                                }else {
                                    print("thêm thất bại")
                                }
                            }
                        }else {
                            self.user.roles = selection.id
                            model.updateUser(userInput: self.user){success in
                                if success {
                                    isOpen = false
                                    isNew = false
                                    print("sửa thành công")
                                }else {
                                    print("sửa thất bại")
                                }
                            }
                        }
                        
                        
                    }, label: {
                        Text(isNew ? "ADD" :"EDIT")
                            .bold()
                            .padding()
                    })
                    .frame(width: 100, height: 50)
                    .buttonStyle(.borderedProminent)
                    Button(action: {isOpen = false
                        isNew = false
                    }, label: {
                        Text("CANCEL")
                            .bold()
                            .padding()
                    })
                    .frame(width: 100, height: 50)
                    .buttonStyle(.borderedProminent)
                    //                .foregroundColor(.pink)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .cornerRadius(10)
            .padding()
        }
    }
}
