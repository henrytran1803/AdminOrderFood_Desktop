//
//  MainView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI
import Charts
struct ValuePerCategory{
    var category: String
    var value : Int
}
struct MainView: View {
    @ObservedObject var modelUser = UserViewModel()
    @ObservedObject var modelProduct = ProductListViewModel()
    @ObservedObject var modelCategory = CategoryListViewModel()
    @ObservedObject var modelOrder = OrderViewModel()
    var body: some View {
        VStack{
            HStack{
                Text("DashBoard")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
                .padding()
           
            VStack{
                HStack{
                    Spacer()
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 400, height: 200)
                        .foregroundColor(.gray.opacity(0.3))
                        .overlay{
                            Text("User: \(modelUser.users.count)")
                                .bold()
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        }
                    Spacer()
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 400, height: 200)
                        .foregroundColor(.blue.opacity(0.3))
                        .overlay{
                            Text("Category: \(modelCategory.categories.count)")
                                .bold()
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        }
                    Spacer()
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 400, height: 200)
                        .foregroundColor(.gray.opacity(0.3))
                        .overlay{
                            Text("Product: \(modelProduct.products.count)")
                                .bold()
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        }
                    Spacer()
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 400, height: 200)
                        .foregroundColor(.blue.opacity(0.3))
                        .overlay{
                            Text("Order: \(modelOrder.orders.count)")
                                .bold()
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                        }
                    Spacer()
                }.padding()
                HStack{
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 400, height: 400)
                        .foregroundColor(.gray.opacity(0.2))
                        .overlay{
                            let data: [ValuePerCategory] = [
                                .init(category: "User", value: modelUser.users.count),
                                .init(category: "Category", value: modelCategory.categories.count),
                                .init(category: "Product", value: modelProduct.products.count),
                                .init(category: "Order", value: modelOrder.orders.count)
                            ]
                            Chart(data, id: \.category) { item in
                                BarMark(
                                    x: .value("Category", item.category),
                                    y: .value("Value", item.value)
                                )
                            }.frame(width: 380, height: 380)
                        }
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 400, height: 400)
                        .foregroundColor(.gray.opacity(0.2))
//                        .overlay{
//                            let data: [ValuePerCategory] = [
//                                .init(category: "NOT_STARTED", value: modelUser.users.count),
//                                .init(category: "IN_PROGRESS", value: modelCategory.categories.count),
//                                .init(category: "COMPLETED", value: modelOrder.orders.filter { $0["statuspayment"] as? String == "paid" }.count),
//                            ]
//                            Chart(data, id: \.category) { item in
//                                BarMark(
//                                    x: .value("Category", item.category),
//                                    y: .value("Value", item.value)
//                                )
//                            }.frame(width: 380, height: 380)
//                        }

                }.padding()
                VStack{
                    RoundedRectangle(cornerRadius: 25)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(.blue.opacity(0.2))
                        .overlay{
                            Chart(modelOrder.orders, id: \.id) { item in
                                LineMark(
                                    x: .value("Category", item.id),
                                    y: .value("Value", item.orderFee)
                                )
                            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                }.padding()
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .cornerRadius(10)
            .padding()
        }.frame(maxHeight: .infinity, alignment: .top)
        .background(Color.blue)
        .onAppear{
            modelUser.fetchAllUser{
                success in
            }
            modelProduct.fetchProducts{
                success in
            }
            modelCategory.fetchCategories()
            modelOrder.fetchAllOrdersByUserId()
        }
    }
}

#Preview {
    MainView()
}
