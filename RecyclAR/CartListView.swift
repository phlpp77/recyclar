//
//  CartListView.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 4/14/23.
//

import SwiftUI

struct CartListView: View {
    
    @State private var cartItems: [CartItem] = []
    @State private var count = 1
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 4) {
                ForEach(cartItems) { cartItem in
                    CartListItemView(product: cartItem.product, count: $count)
                    Text("Test \(cartItem.count)")
                }
            }
            .padding(.horizontal, 28)
        }
        .task {
            cartItems = CartItem.all
        }
    }
}

struct CartListView_Previews: PreviewProvider {
    static var previews: some View {
        CartListView()
    }
}
