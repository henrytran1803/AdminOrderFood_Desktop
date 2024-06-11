//
//  SignUpViewModel.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    @Published var signup: SignUp = SignUp(username: "", email: "", password: "", phone: "", address: "")
    @Published var errorMessage: String? = nil
    var urlstring = "http://127.0.0.1:8080/api/login/signup"
    
    
    func signUpUser(completion: @escaping (Bool, String?) -> Void) {
      guard let url = URL(string: urlstring) else {
        completion(false, "Invalid API URL")
        return
      }

      var urlRequest = URLRequest(url: url)
      urlRequest.httpMethod = "POST"
      urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

      do {
        let jsonData = try JSONEncoder().encode(signup)
        urlRequest.httpBody = jsonData
      } catch {
        completion(false, "Failed to encode signup data: \(error.localizedDescription)")
        return
      }

      let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        DispatchQueue.main.async {
          if let error = error {
            completion(false, "Request failed: \(error.localizedDescription)")
            return
          }

          guard let httpResponse = response as? HTTPURLResponse else {
            completion(false, "Invalid response from server")
            return
          }

          let success = (200...299).contains(httpResponse.statusCode)
          let errorMessage: String? = success ? nil : "Invalid response from server (status code: \(httpResponse.statusCode))"
          completion(success, errorMessage)
        }
      }
      dataTask.resume()
    }

}
