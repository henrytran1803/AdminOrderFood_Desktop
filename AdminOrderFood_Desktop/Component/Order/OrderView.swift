//
//  OrderView.swift
//  AdminOrderFood_Desktop
//
//  Created by Tran Viet Anh on 10/6/24.
//

import SwiftUI

struct OrderView: View {
    @ObservedObject var model = OrderViewModel()
    @ObservedObject var modelpay = PaymentViewModel()
    var body: some View {
        VStack{
            HStack{
                Text("Orders")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.white)
                Spacer()
            }
                .padding()
           
            VStack{
                HStack{
                    Text("List order")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.secondary)
                    Spacer()
                }.padding()
                Divider()
                List{
                    ForEach($model.orders,id: \.id){ order in
                        HStack{
                            if let paymentResponse = modelpay.paymentResponses[order.id]?.data {
                                    OrderItemRow(order: order, paymentResponse: paymentResponse)
                                } else {
                                    OrderItemRow(order: order, paymentResponse: PaymentData(id: 0, paymentStatus: "", orderId: 0, userId: 0, orderReponse: "", payed: false))
                                        .onAppear {
                                            modelpay.getPaymentByOrderId(orderId: order.id)
                                        }
                                }
                            Button(action: {
                               if var paymentResponse = modelpay.paymentResponses[order.id]?.data, paymentResponse.payed == false {
                                   modelpay.updatePaymentById(id: paymentResponse.id, idOrder: paymentResponse.orderId, idUser: paymentResponse.userId, isPayed: true, paymentStatus: paymentResponse.paymentStatus)
                                   modelpay.paymentResponses[order.id]?.data.payed = true
                               }
                           }, label: {
                               if let paymentResponse = modelpay.paymentResponses[order.id]?.data, paymentResponse.payed == false {
                                   Text("Đã thanh toán")
                                       .bold()
                                       .padding()
                               }
                           })
                            .frame(width: 100, height: 50)
                            .buttonStyle(.borderedProminent)
                           Button(action: {
                               if var paymentResponse = modelpay.paymentResponses[order.id]?.data {
                                   if paymentResponse.paymentStatus == "NOT_STARTED" {
                                       modelpay.updatePaymentById(id: paymentResponse.id, idOrder: paymentResponse.orderId, idUser: paymentResponse.userId, isPayed: paymentResponse.payed ?? false, paymentStatus: "IN_PROGRESS")
                                       modelpay.paymentResponses[order.id]?.data.paymentStatus = "IN_PROGRESS"
                                   } else if paymentResponse.paymentStatus == "IN_PROGRESS" {
                                       modelpay.updatePaymentById(id: paymentResponse.id, idOrder: paymentResponse.orderId, idUser: paymentResponse.userId, isPayed: paymentResponse.payed  ?? false, paymentStatus: "COMPLETED")
                                       modelpay.paymentResponses[order.id]?.data.paymentStatus = "COMPLETED"
                                       
                                   }
                               }
                           }, label: {
                               if let paymentResponse = modelpay.paymentResponses[order.id]?.data {
                                   if paymentResponse.paymentStatus == "NOT_STARTED" {
                                       Text("Đang chuẩn bị")
                                           .bold()
                                           .padding()
                                   } else if paymentResponse.paymentStatus == "IN_PROGRESS" {
                                       Text("Giao thành công")
                                           .bold()
                                           .padding()
                                   }
                               }
                           }).frame(width: 100, height: 50)
                                .buttonStyle(.borderedProminent)
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
            model.fetchAllOrdersByUserId()
        }
    }
}

#Preview {
    OrderView()
}
