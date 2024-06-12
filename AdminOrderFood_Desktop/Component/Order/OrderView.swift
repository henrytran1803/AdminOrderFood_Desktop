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
                            OrderItemRow(order: order)
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
