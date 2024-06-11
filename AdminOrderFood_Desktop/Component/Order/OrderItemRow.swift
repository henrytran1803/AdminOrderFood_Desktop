//
//  OrderItemRow.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct OrderItemRow: View {
    @Binding var order : Order
    @State var paymentResponse: PaymentData
    var body: some View {
        HStack{
            Text("ID:")
                .bold()
            Text("\(order.id)")
            Spacer()
            Text("Total:")
                .bold()
            Text("\(order.orderFee)")
            Text("is Pay:")
                .bold()
            if let payed = paymentResponse.payed {
                    Text(payed ? "Đã thanh toán" : "Chưa thanh toán")
                        .foregroundColor(payed ? .green : .red)
                } else {
                    Text("Chưa thanh toán")
                        .foregroundColor(.red)
                }
            Text("Status:")
                .bold()
            Text("\(paymentResponse.paymentStatus)")
                .foregroundColor(paymentResponse.paymentStatus == "NOT_STARTED" ? paymentResponse.paymentStatus == "IN_PROGRESS" ? .red : .green : .blue)
            Spacer()
        }
        .font(.title)
        .padding()
    }
}
