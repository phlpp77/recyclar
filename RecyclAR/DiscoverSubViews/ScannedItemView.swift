//
//  ScannedItemView.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 4/6/23.
//

import SwiftUI

struct ScannedItemView: View {
    
    let product: Product
    
    var body: some View {
        NavigationLink {
            ScannedItemDetailView(product: product)
        } label: {
            VStack(spacing: 9.0) {
                Image(product.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .padding(10)
                    .frame(width: 84, height: 84)
                    .background(
                        ZStack {
                            Circle()
                                .fill(Material.regular)
                            Circle()
                                .strokeBorder(Color.gray, lineWidth: 1)
                        }
                    )
                Text(product.name)
                    .foregroundColor(.black)
            }
            .frame(width: 110)
        }
            
    }
}

struct ScannedItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScannedItemView(product: Product(name: "Cheerios", imageName: "cheerios", sustainabilityPoints: 80, price: 1.0))
    }
}
