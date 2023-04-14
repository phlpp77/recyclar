//
//  ScannedItemDetailView.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 4/10/23.
//

import SwiftUI

struct ScannedItemDetailView: View {
    
    let product: Product
    
    var body: some View {
        VStack(spacing: 9.0) {
            
            // Product image and background frame
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .padding(10)
                .frame(width: 250, height: 250)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Material.regular)
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(Color.gray, lineWidth: 1)
                    }
                )
            
            // Product name
            Text(product.name)
                .font(.title)
                .foregroundColor(.black)
            
            // Sustainability score
            Text("Sustainability score: **\(product.sustainabilityPoints)**")
            
            Spacer()
        }
        .padding(.top, 28)
        .navigationTitle(product.name)
    }
}

struct ScannedItemDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        ScannedItemDetailView(product: Product(name: "Cheerios", imageName: "cheerios", sustainabilityPoints: 80, price: 1.0))
    }
}
