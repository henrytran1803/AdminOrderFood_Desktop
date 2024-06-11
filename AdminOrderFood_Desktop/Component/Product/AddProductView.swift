//
//  AddProductView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI


struct AddProductView: View {
    @StateObject private var viewModel = ProductUploadViewModel()
    @State private var name = ""
    @State private var fileURL: URL? = nil
    @State private var price: Double = 0.0
    @State private var quantity: Int = 0
    @State private var idCategory: Int = 0
    @State private var description = ""
    @State var selectedCategoryIndex = 0
    @State var liscate: [Category]
    @Binding var isAdd: Bool
    var body: some View {
        VStack {
            Picker("Select Category", selection: $selectedCategoryIndex) {
                ForEach(0..<liscate.count, id: \.self) { index in
                    Text(liscate[index].name)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            TextField("Name", text: $name)
            TextField("Price", value: $price, formatter: NumberFormatter())
            TextField("Quantity", value: $quantity, formatter: NumberFormatter())
            TextField("Description", text: $description)
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
            HStack{
                
                Button(action: { if let fileURL = fileURL {
                    viewModel.uploadProduct(name: name, fileURL: fileURL, price: price, quantity: quantity, idCategory: liscate[selectedCategoryIndex].id, description: description)
                }
                }, label: {
                    Text("Upload Product")
                        .bold()
                        .padding()
                })
                .frame(width: 200, height: 50)
                .buttonStyle(.borderedProminent)
                Button(action: {  isAdd = false
                }, label: {
                    Text("Cancel")
                        .bold()
                        .padding()
                })
                .frame(width: 200, height: 50)
                .buttonStyle(.borderedProminent)
                if viewModel.uploadSuccess {
                    Text("Upload Successful")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                }
            }


           
        }
        .padding()
        .background(Color.white)
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



#Preview {
    AddProductView(liscate: [Category(id: 1, name: "aaaa"),], isAdd: .constant(true))
}
