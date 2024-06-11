//
//  UserItemRow.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct UserItemRow: View {
    @State var user : User
    var body: some View {
        HStack{
            Text("ID:")
                .bold()
            Text("\(user.id)")
            Spacer()
            Text("Username:")
                .bold()
            Text("\(user.username)")
            Text("Email:")
                .bold()
            Text("\(user.email)")
            Text("Phone:")
                .bold()
            Text("\(user.phone)")
            Text("Address:")
                .bold()
            Text("\(user.address)")
            Spacer()
            
        }/*(id: 5, username: "username12334", email: "emai123@gmail.com", createDate: "2024-06-09T15:09:30.902+00:00", phone: "+84 blabla", address: "address", roles: 1)*/
        .font(.title)
        .padding()
    }
}

