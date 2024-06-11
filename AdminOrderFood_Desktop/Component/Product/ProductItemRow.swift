//
//  ProductItemRow.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct ProductItemRow: View {
    @Binding var product : Product
    var body: some View {
        Text("ID:")
            .bold()
        Text("\(product.id)")
        Text("Name:")
            .bold()
        Text("\(product.name)")
        Text("Price:")
            .bold()
        Text("\(product.price)")
        Text("Quantity:")
            .bold()
       
        Text("\(product.quantity)")
        Spacer()
        if let imageData = Data(base64Encoded: product.imageData), let nsImage = NSImage(data: imageData) {
                    Image(nsImage: nsImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .cornerRadius(20)
                } else {
                    Text("Invalid image data")
                }

        Spacer()
    }
}
