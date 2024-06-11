//
//  TextFieldView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct TextFieldView: View {
    @State var name = ""
    @Binding var textInput: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(name)
                .font(.title3)
                .foregroundStyle(.secondary)
            TextField("Please fill \(name)", text: $textInput)
                .textFieldStyle(.roundedBorder)
                .padding()
                .frame(width: 300, height: 50)
        }.font(.system(size: 17))
    }
}

