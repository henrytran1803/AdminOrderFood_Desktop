//
//  Product.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import Foundation
struct Product: Codable, Identifiable  {
    var id: Int
    var name: String
    var image: String
    var imageData: String
    var price: Double
    var description: String
    var quantity: Int
    var category: Category
}
struct ProductResponse: Codable {
    var statusCode: Int
    var message: String
    var data: [Product]
}

struct ProductSingleResponse: Codable {
    var statusCode: Int
    var message: String
    var data: Product
}
 
