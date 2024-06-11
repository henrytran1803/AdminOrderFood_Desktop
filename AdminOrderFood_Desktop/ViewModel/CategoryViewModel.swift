//
//  CategoryViewModel.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import Foundation

class CategoryListViewModel: ObservableObject {
  @Published var categories: [Category] = []
  @Published var errorMessage: String? = nil
    init(){
        fetchCategories()
    }
  func fetchCategories() {
    guard let url = URL(string: "http://127.0.0.1:9000/api/categories") else {
      errorMessage = "Invalid API URL"
      return
    }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    
    let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
      DispatchQueue.main.async {
        if let error = error {
          self.errorMessage = error.localizedDescription
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
          self.errorMessage = "Failed to fetch categories. Check server response."
          return
        }
        
        guard let data = data else {
          self.errorMessage = "No data received from server."
          return
        }
        
        do {
          let decodedResponse = try JSONDecoder().decode(CategoryResponse.self, from: data)
          self.categories = decodedResponse.data
        } catch {
          self.errorMessage = "Error decoding JSON data: \(error.localizedDescription)"
        }
      }
    }
    dataTask.resume()
  }
    func deleteCategory(by id: Int, completion: @escaping (Bool) -> Void) {
        let apiID = "http://127.0.0.1:9000/api/categories/\(id)"
        guard let url = URL(string: apiID) else {
            self.errorMessage = "Invalid API URL"
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    self.errorMessage = "Failed to delete category. Check server response."
                    completion(false)
                    return
                }
                
                self.categories.removeAll { $0.id == id }
                print("Category with ID \(id) has been deleted.")
                completion(true)
            }
        }
        
        dataTask.resume()
    }
    
    func updateCategory(category: Category, completion: @escaping (Bool) -> Void) {
        let apiID = "http://127.0.0.1:9000/api/categories/\(category.id)"
        guard let url = URL(string: apiID) else {
            self.errorMessage = "Invalid API URL"
            print("Invalid API URL1")
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let formData = "name=\(category.name)"
        request.httpBody = formData.data(using: .utf8)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    print("Invalid API URL2")
                    completion(false)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    self.errorMessage = "Failed to update category. Check server response."
                    completion(false)
                    print("Invalid API URL3")
                    return
                }
                
                if let index = self.categories.firstIndex(where: { $0.id == category.id }) {
                    self.categories[index] = category
                }
                print("Category with ID \(category.id) has been updated.")
                completion(true)
            }
        }
        dataTask.resume()
    }
    func addCategory(name: String, completion: @escaping (Bool) -> Void) {
         let apiURL = "http://127.0.0.1:9000/api/categories"
         guard let url = URL(string: apiURL) else {
             self.errorMessage = "Invalid API URL"
             
             completion(false)
             return
         }
         
         var request = URLRequest(url: url)
         request.httpMethod = "POST"
         request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
         
         let formData = "name=\(name)"
         request.httpBody = formData.data(using: .utf8)
         
         let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
             DispatchQueue.main.async {
                 if let error = error {
                     self.errorMessage = error.localizedDescription
                     completion(false)
                     return
                 }
                 
                 guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                     self.errorMessage = "Failed to add category. Check server response."
                     completion(false)
                     return
                 }
                 
                 guard let data = data else {
                     self.errorMessage = "No data received from server."
                     completion(false)
                     return
                 }
                 print(data)
                 do {
                     let decodedResponse = try JSONDecoder().decode(Basresponse.self, from: data)
                     completion(true)
                 } catch {
                     self.errorMessage = "Error decoding JSON data: \(error.localizedDescription)"
                     completion(false)
                 }
             }
         }
         
         dataTask.resume()
     }
}
