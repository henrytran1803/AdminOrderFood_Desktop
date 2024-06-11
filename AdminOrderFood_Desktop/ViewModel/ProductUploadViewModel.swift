//
//  ProductUploadViewModel.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import Foundation
import SwiftUI

class ProductUploadViewModel: ObservableObject {
    @Published var uploadSuccess = false
    @Published var errorMessage: String?

    func uploadProduct(name: String, fileURL: URL, price: Double, quantity: Int, idCategory: Int, description: String) {
        let url = URL(string: "http://localhost:9000/api/products")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        // Thêm trường văn bản
        let parameters: [String: String] = [
            "name": name,
            "price": String(price),
            "quantity": String(quantity),
            "idCategory": String(idCategory),
            "description": description
        ]
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        let fileName = fileURL.lastPathComponent
        let mimeType = "image/jpeg"
        let fileData = try! Data(contentsOf: fileURL)
        
        body.append("--\(boundary)\r\n")
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n")
        body.append("Content-Type: \(mimeType)\r\n\r\n")
        body.append(fileData)
        body.append("\r\n")
        body.append("--\(boundary)--\r\n")
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    self.uploadSuccess = true
                } else {
                    self.errorMessage = "Upload failed"
                }
            }
        }
        
        task.resume()
    }
    func updateProduct(id: Int, name: String, fileURL: URL?, price: Double, quantity: Int, idCategory: Int, description: String) {
        let url = URL(string: "http://localhost:9000/api/products/\(id)")! // URL cho PUT request với id sản phẩm cần sửa
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        let parameters: [String: String] = [
            "name": name,
            "price": String(price),
            "quantity": String(quantity),
            "idCategory": String(idCategory),
            "description": description
        ]
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        if let fileURL = fileURL {
            let fileName = fileURL.lastPathComponent
            let mimeType = "image/jpeg"
            let fileData = try! Data(contentsOf: fileURL)
            
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n")
            body.append("Content-Type: \(mimeType)\r\n\r\n")
            body.append(fileData)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    self.uploadSuccess = true
                } else {
                    self.errorMessage = "Update failed"
                }
            }
        }
        
        task.resume()
    }

}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
