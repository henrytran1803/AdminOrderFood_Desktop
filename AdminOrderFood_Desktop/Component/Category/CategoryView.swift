//
//  CategoryView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var model = CategoryListViewModel()
    @State var isEdit = false
    @State var newName = ""
    @State var id = 0
    var body: some View {
        VStack{
            HStack{
                Text("Categories")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
                .padding()
           
            VStack{
                HStack{
                    Text("List Category")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.secondary)
                    Spacer()
               
                }.padding()
                Divider()
                HStack{
                    Text("ADD Category")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.secondary)
                    Spacer()
                    TextField("Category", text: $newName)
                    if isEdit {
                        Button(action: {
                            let category = Category(id: self.id, name: self.newName)
                            print(category)
                            model.updateCategory(category:category ){success in
                                if success {
                                    model.categories = []
                                    model.fetchCategories()
                                    id = 0
                                    newName = ""
                                }else {
                                    print("fail1")
                                }
                            }
                        }, label: {
                            Image(systemName: "checkmark.seal")
                                .foregroundColor(.yellow)
                                .font(.title)
                        })
                    } else {
                        Button(action: {
                            model.addCategory(name: newName){success in
                                if success {
                                    model.categories = []
                                    model.fetchCategories()
                                    id = 0
                                    newName = ""
                                }else {
                                    print("fail2")
                                }
                            }
                        }, label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.yellow)
                                .font(.title)
                        })
                    }
                    
                }.padding()
                List{
                    ForEach(model.categories,id: \.id){ category in
                        HStack{
                            CategoryItemRow(category: category)
                            Button(action: {
                                model.deleteCategory(by: category.id){success in
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
                                    self.id = category.id
                                    self.newName = category.name
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
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .cornerRadius(10)
            .padding()
        }.frame(maxHeight: .infinity, alignment: .top)
        .background(Color.blue)
        .onAppear{
            model.fetchCategories()
        }
    }
}

#Preview {
    CategoryView()
}
