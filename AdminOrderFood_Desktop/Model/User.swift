//
//  User.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import Foundation
struct User: Codable {
    var id: Int
    var username: String
    var email: String
    var createDate: String
    var phone: String
    var address: String
    var roles: Int
}
struct UserResponse : Codable{
    var statusCode: Int
    var message: String
    var data: User
}

struct UsersResponse : Codable{
    var statusCode: Int
    var message: String
    var data: [User]
}

