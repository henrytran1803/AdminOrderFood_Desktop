//
//  ProductView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct ProductView: View {
    @State var isAdd = false
    @State private var selectedProductIndex: Int? = nil
    @ObservedObject var model = ProductListViewModel()
    @State var modelCate = CategoryListViewModel()
    @State var product = Product(id: 0, name: "", image: "", imageData: "", price: 1, description: "", quantity: 1, category: Category(id: 1, name: ""))
    @State var isEdit = false
    var body: some View {
        VStack{
            HStack{
                Text("Products")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
                .padding()
            VStack{
                if isAdd && !isEdit {
                    AddProductView(liscate: modelCate.categories, isAdd: $isAdd)
                        .onDisappear{
                            model.fetchProducts{success in
                            }
                        }
                }else if !isAdd && isEdit{
                    ProductDetailView(isEditing: $isEdit, product: model.products[selectedProductIndex ?? 0], liscate: modelCate.categories)
                        .onDisappear{
                            model.fetchProducts{success in
                            }
                        }
            }else {
                    HStack{
                        Text("List Product")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.secondary)
                        Spacer()
                        Button(action: {
                            isAdd = true
                        }, label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.blue)
                                .bold()
                        })
                    }.padding()
                    Divider()
                    List{
                        ForEach($model.products,id: \.id){ product in
                            HStack{
                                ProductItemRow(product: product)
                                    .font(.system(size: 20))
                                Button(action: {
                                    model.deleteProduct(by: product.id){success in
                                        if success {
                                            print("xoá thành công")
                                        }else {
                                            print("xoá thất bại")
                                        }
                                    }
                                }, label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.pink)
                                        .font(.title)
                                })
                                Button(action: {
                                    selectedProductIndex = model.products.firstIndex(where: { $0.id == product.id })
                                    
                                    isEdit = true
                                }, label: {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.yellow)
                                        .font(.title)
                                })
                            }
                            
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .cornerRadius(10)
            .padding()
        }.frame(maxHeight: .infinity, alignment: .top)
        .background(Color.blue)
        .onAppear{
            modelCate.fetchCategories()
        }
    }
}
