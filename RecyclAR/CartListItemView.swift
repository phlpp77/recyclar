//
//  CartListItemView.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 4/14/23.
//

import SwiftUI

struct CartListItemView: View {
    
    let product: Product
    
    @Binding var count: Int
    
    var body: some View {
        HStack {
            
            // Product image
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                //.frame(height: 95)
                .frame(width: 95, height: 95) // Add frame to ensure all images have the same size
                //.background(Color.gray.opacity(0.2)) // Add background color to show image frame
                
            
            // Text details
            VStack(alignment: .leading, spacing: 5.0) {
                Text(product.name)
                    .font(.title3)
                    .foregroundColor(.black)
                Text("\(product.sustainabilityPoints) pts")
                Text("$\(String(format: "%.2f", product.price))")
            }
            .foregroundColor(.gray)
            
            // Change count of cart
            Stepper("", value: $count, in: 0...99)
        }
    }
}

struct CartListItemView_Previews: PreviewProvider {
        
    static var previews: some View {
        CartListItemView(product: Product(name: "Cheerios", imageName: "cheerios", sustainabilityPoints: 80, price: 1.00), count: .constant(1))
    }
}
