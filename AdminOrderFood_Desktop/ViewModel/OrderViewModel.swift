//
//  OrderViewModel.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    @Published var errorMessage: String?
    
    func fetchAllOrdersByUserId() {
        let urlString = "http://localhost:9000/api/orders"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    self?.errorMessage = "Server error with status code \(statusCode)"
                    return
                }
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                do {
                    let orderResponse = try JSONDecoder().decode(OrderResponse.self, from: data)
                    self?.orders = orderResponse.data
                } catch {
                    self?.errorMessage = "Error decoding JSON data: \(error.localizedDescription)"
                }
            }
        }
        
        dataTask.resume()
    }
 
}
