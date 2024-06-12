//
//  OrderItemRow.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct OrderItemRow: View {
    @Binding var order: Order
    @StateObject var modelpay = PaymentViewModel()
    
    var body: some View {
        HStack {
            Text("ID:")
                .bold()
            Text("\(order.id)")
            Spacer()
            Text("Total:")
                .bold()
            Text("\(order.orderFee)")
            Text("is Pay:")
                .bold()
            if let payed = modelpay.paymentData.payed {
                Text(payed ? "Đã thanh toán" : "Chưa thanh toán")
                    .foregroundColor(payed ? .green : .red)
            } else {
                Text("Chưa thanh toán")
                    .foregroundColor(.red)
            }
            Text("Status:")
                .bold()
            Text("\(modelpay.paymentData.paymentStatus)")
                .foregroundColor(modelpay.paymentData.paymentStatus == "NOT_STARTED" ? .red : modelpay.paymentData.paymentStatus == "IN_PROGRESS" ? .blue : .green)
            Spacer()
            Button(action: {
                if modelpay.paymentData.payed == false {
                    modelpay.updatePaymentById(id: modelpay.paymentData.id, idOrder: modelpay.paymentData.orderId, idUser: modelpay.paymentData.userId, isPayed: true, paymentStatus: modelpay.paymentData.paymentStatus)
                }
            }, label: {
                if modelpay.paymentData.payed == false {
                    Text("Đã thanh toán")
                        .bold()
                        .padding()
                }
            })
            .frame(width: 100, height: 50)
            .buttonStyle(.borderedProminent)
            Button(action: {
                if modelpay.paymentData.paymentStatus == "NOT_STARTED" {
                    modelpay.updatePaymentById(id: modelpay.paymentData.id, idOrder: modelpay.paymentData.orderId, idUser: modelpay.paymentData.userId, isPayed: modelpay.paymentData.payed ?? false, paymentStatus: "IN_PROGRESS")
                    modelpay.paymentData.paymentStatus = "IN_PROGRESS"
                } else if modelpay.paymentData.paymentStatus == "IN_PROGRESS" {
                    modelpay.updatePaymentById(id: modelpay.paymentData.id, idOrder: modelpay.paymentData.orderId, idUser: modelpay.paymentData.userId, isPayed: modelpay.paymentData.payed ?? false, paymentStatus: "COMPLETED")
                    modelpay.paymentData.paymentStatus = "COMPLETED"
                }
            }, label: {
                if modelpay.paymentData.paymentStatus == "NOT_STARTED" {
                    Text("Đang chuẩn bị")
                        .bold()
                        .padding()
                } else if modelpay.paymentData.paymentStatus == "IN_PROGRESS" {
                    Text("Giao thành công")
                        .bold()
                        .padding()
                }
            })
            .frame(width: 100, height: 50)
            .buttonStyle(.borderedProminent)
        }
        .font(.title)
        .padding()
        .onAppear {
            modelpay.getPaymentByOrderId(orderId: order.id)
            print(order.id)
        }
    }
}
