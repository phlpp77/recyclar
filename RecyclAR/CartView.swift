//
//  CartView.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 3/10/23.
//

import SwiftUI

struct CartView: View {
    @State private var cartItems = CartItem.all

    var totalPoints: Int {
        return cartItems.reduce(0) { total, item in
            total + (item.product.sustainabilityPoints * item.count)
        }
    }
    
    var totalPayment: Double {
        return cartItems.reduce(0.0) { total, item in
            total + (item.product.price * Double(item.count))
        }
    }
    
    
    var body: some View {
        VStack {
            
            Text("Points Preview")
                .font(.title)
            
            // QR Code
            NavigationLink {
                QRCodeView()
                    .navigationTitle("Personal code")
            } label: {
                Image(systemName: "qrcode")
                    .font(.system(size: 150))
                    .padding(.top, 25)
                    .foregroundColor(.black)
            }
            
            Text("Tap code to enlarge")
                .padding(.top, 2)
            
            // Total points and payments
            VStack(spacing: 10.0) {
                HStack {
                    Text("Total points")
                    Spacer()
                    Text("\(totalPoints) pts")
                }
                HStack {
                    Text("Total payment")
                    Spacer()
                    Text("$\(totalPayment, specifier: "%.2f")")
                }
            }
            .font(.title2)
            .padding(.horizontal, 52)
            .padding(.top, 28)
            
            CartListView()
                .padding(.top, 50)
            Spacer()
        }
        .navigationTitle("Points Preview")
    }
}

struct ScoresView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
