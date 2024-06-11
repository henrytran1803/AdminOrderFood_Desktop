//
//  CategoryItemRow.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct CategoryItemRow: View {
    @State var category : Category
    var body: some View {
        HStack{
            Text("ID:")
                .bold()
            Text("\(category.id)")
            Spacer()
            Text("Name:")
                .bold()
            TextField("Category", text: $category.name)
                .disabled(true)
        }
        .font(.title)
        .padding()
    }
}
