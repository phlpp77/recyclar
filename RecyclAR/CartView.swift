//
//  CartView.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 3/10/23.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        VStack {
            
            // QR Code
            Image(systemName: "qrcode")
                .font(.system(size: 150))
            Text("Tap to enlarge")
                .padding(.top, 2)
            
            // Total points and payments
            VStack(spacing: 10.0) {
                HStack {
                    Text("Total points")
                    Spacer()
                    Text("130 pts")
                }
                HStack {
                    Text("Total payment")
                    Spacer()
                    Text("$2.98")
                }
            }
            .font(.title2)
            .padding(.horizontal, 52)
            .padding(.top, 28)
            
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
