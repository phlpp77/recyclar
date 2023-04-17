//
//  QRCodeView.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 4/16/23.
//

import SwiftUI

struct QRCodeView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "qrcode")
                .font(.system(size: 250))
            Text("Scan me to boost your Sustainability Points")
                .padding(.top, 2)
            Spacer()
            Text("Your personal data will be used only to process your order. For more details, please see [Privacy Policy](https://gatech.edu).")
                .font(.footnote)
                .padding(.horizontal, 28)
        }
    }
}

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeView()
    }
}
