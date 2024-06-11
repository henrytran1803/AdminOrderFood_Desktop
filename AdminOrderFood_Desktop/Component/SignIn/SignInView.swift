//
//  SignInView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var modelSignIn = SignInViewModel()
    @Binding var isLogin:Bool
    @State var error = false
    var body: some View {
        
        HStack{
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
                    .padding(.bottom)
                VStack(alignment: .leading, spacing: -15){
                    Text("Email")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 12))
                    TextField("Enter your email address", text: $modelSignIn.signIn.username)
                        .frame(width: 250, height: 70)
                        .font(.system(size: 17))
                }
                VStack(alignment: .leading, spacing: -15){
                    Text("Password")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 12))
                    SecureField("Enter your password", text: $modelSignIn.signIn.password)
                        .frame(width: 250, height: 70)
                        .font(.system(size: 17))
                }
                Button(action: {
                    modelSignIn.Login{success in
                        if success {
                            isLogin = true
                        }else {
                            error = true
                            print("erree")
                            
                        }
                    }
                }, label: {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 200, height: 50)
                        .foregroundColor(.blue)
                        .overlay{
                            Text("Đăng nhập")
                                .bold()
                                .foregroundColor(.white)
                        }
                })
            }.padding(100)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image("Image")
                    Spacer()
                }
//                }.background(Color.gray.opacity(0.3))
                Spacer()
            }.padding(100)
            .background(Color.gray.opacity(0.3))
            
            
            
        }.frame(width: getRect().width / 1.3, height: getRect().height - 100 , alignment: .leading)
            .background(Color.white.ignoresSafeArea())
            .buttonStyle(PlainButtonStyle())
        .alert("Đừng bỏ trống", isPresented: $error) {
                Button("OK", role: .cancel) { }
        }
   
        
    }
}

