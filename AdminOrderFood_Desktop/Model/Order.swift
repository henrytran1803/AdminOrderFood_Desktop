//
//  Order.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import Foundation
struct Order: Codable, Identifiable {
    var id: Int
    var orderDesc: String?
    var orderFee: Double
    var orderDate: String?
    var userId: Int
    var orderDetails: [OrderDetail]
}

struct OrderDetail: Codable, Identifiable {
    var id: Int
    var productId: Int
    var quantity: Int
    var productName: String?
    var productPrice: Double?
    var productImage: String?
}
struct OrderResponse: Codable {
    var statusCode: Int
    var message: String
    var data: [Order]
}
struct OrderResponseCreate: Codable {
    var statusCode: Int
    var message: String
    var data: Int
}
enum payment {
    case NOT_STARTED, IN_PROGRESS, COMPLETED
}
