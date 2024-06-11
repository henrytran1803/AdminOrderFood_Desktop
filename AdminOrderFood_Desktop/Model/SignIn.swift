//
//  SignIn.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import Foundation
struct SignIn: Codable {
    var username: String
    var password: String
}
struct SignInResponse:Codable{
    let statusCode: Int
    let message: String
    let data: SignInData
}
struct SignInData: Codable {
    let id: Int
    let token: String
}

