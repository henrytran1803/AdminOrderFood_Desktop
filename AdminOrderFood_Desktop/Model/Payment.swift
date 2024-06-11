//
//  Payment.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import Foundation
struct PaymentResponse: Codable {
    var statusCode: Int
    var message: String
    var data: PaymentData
}

struct PaymentData: Codable {
    var id: Int
    var paymentStatus: String
    var orderId: Int
    var userId: Int
    var orderReponse: String?
    var payed: Bool?
}
