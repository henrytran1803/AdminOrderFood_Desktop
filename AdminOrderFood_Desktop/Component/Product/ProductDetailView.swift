//
//  ProductDetailView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI


struct ProductDetailView: View {
    @StateObject var viewModel = ProductUploadViewModel()
    @Binding var isEditing:Bool
    @State var product: Product
    @State var selectedCategoryIndex = 0
    @State var liscate: [Category]
    @State private var fileURL: URL? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Product Details")
                .font(.title)
                .fontWeight(.bold)
            Picker("Select Category", selection: $selectedCategoryIndex) {
                ForEach(0..<liscate.count, id: \.self) { index in
                    Text(liscate[index].name)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
                TextField("Name", text: $product.name)
                TextField("Price", value: $product.price, formatter: NumberFormatter())
                TextField("Quantity", value: $product.quantity, formatter: NumberFormatter())
                TextField("Description", text: $product.description)
            if let imageData = Data(base64Encoded: product.imageData), let nsImage = NSImage(data: imageData) {
                        Image(nsImage: nsImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .cornerRadius(20)
                    } else {
                        Text("Invalid image data")
                    }
            Button(action: {
                self.pickFile()
            }) {
                Text("Select File")
            }.foregroundColor(.black)
                .padding()
                .frame(width: 100, height: 50)
                .buttonStyle(.borderedProminent)
            if let fileURL = fileURL {
                Text("Selected file: \(fileURL.lastPathComponent)")
                    .foregroundColor(.black)
            }
            Button("Save Changes") {
                
                viewModel.updateProduct(id: product.id, name: product.name, fileURL: fileURL, price: product.price, quantity: product.quantity, idCategory: liscate[selectedCategoryIndex].id, description: product.description)
                isEditing.toggle()
                
            }
            Spacer()
        }
        .padding()
    }
    
    private func pickFile() {
        let panel = NSOpenPanel()
        panel.allowedFileTypes = ["jpg", "png", "jpeg"]
        panel.begin { response in
            if response == .OK {
                self.fileURL = panel.url
            }
        }
    }
}



