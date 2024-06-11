//
//  Category.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import Foundation

struct Category: Codable, Identifiable, Equatable, Hashable {
    var id: Int
    var name: String
}
struct CategoryResponse: Codable {
    var statusCode: Int
    var message: String
    var data: [Category]
}
struct Basresponse: Codable {
    var statusCode: Int
    var message: String
    var data: Bool
}
