//
//  PaymentViewModel.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import Foundation

class PaymentViewModel: ObservableObject {
    @Published var orders: [Order] = []
    private let baseURL = "http://127.0.0.1:9000/api/payments/order/"
    @Published var updateSuccess = false
    @Published var paymentData : PaymentData = PaymentData(id: 0, paymentStatus: "", orderId: 0, userId: 0, orderReponse: "", payed: true)
    @Published var errorMessage: String?
    
    func getPaymentByOrderId(orderId: Int) {
        guard let url = URL(string: "\(baseURL)\(orderId)") else {
            errorMessage = "Invalid URL"
            print(errorMessage)
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    print(self.errorMessage)
                    return
                }
                
                guard let data = data else {
                    self.errorMessage = "No data received"
                    print(self.errorMessage)
                    return
                }
                print("Raw data received: \(String(describing: String(data: data, encoding: .utf8)))")
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let paymentResponse = try decoder.decode(PaymentResponse.self, from: data)
                        print("Decoded successfully: \(paymentResponse)")
                        self.paymentData = paymentResponse.data
                    } catch {
                        self.errorMessage = "Failed to decode response data: \(error.localizedDescription)"
                        print(self.errorMessage)
                    }
                } else {
                    self.errorMessage = "Failed to get payment by order id"
                    if let httpResponse = response as? HTTPURLResponse {
                        print("HTTP Status Code: \(httpResponse.statusCode)")
                        print("HTTP Response: \(httpResponse)")
                    }
                    print(self.errorMessage)
                }
            }
        }.resume()
    }

    func updatePaymentById(id: Int, idOrder: Int, idUser: Int, isPayed: Bool, paymentStatus: String) {
        guard let url = URL(string: "http://127.0.0.1:9000/api/payments/\(id)") else {
            errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        let parameters: [String: String] = [
            "idOrder": String(idOrder),
            "idUser": String(idUser),
            "idPayed": String(isPayed),
            "paymentStatus": paymentStatus
        ]
        print(parameters)
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
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
                    self.getPaymentByOrderId(orderId: idOrder) // Reload the payment info

                    self.updateSuccess = true
                } else {
                    do {
                        let decoder = JSONDecoder()
                        let errorResponse = try decoder.decode(BaseResponse.self, from: data)
                        self.errorMessage = errorResponse.message
                    } catch {
                        self.errorMessage = "Update failed"
                    }
                }
            }
        }.resume()
    }


}
struct BaseResponse: Codable {
    let statusCode: Int
    let message: String
    let data: Bool?
}
