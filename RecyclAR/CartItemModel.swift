//
//  CartItemModel.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 4/14/23.
//

import Foundation

struct CartItem: Identifiable {
    
//    static var all: [CartItem] = [CartItem(product: Product(name: "Cheerios", imageName: "cheerios", sustainabilityPoints: 80, price: 1.0), count: 1), CartItem(product: Product(name: "Cheerios", imageName: "cheerios", sustainabilityPoints: 80, price: 1.0), count: 1)]
    
//    static var all: [CartItem] = []
    
        static var all: [CartItem] = [CartItem(product: Product(name: "Cheerios", imageName: "cheerios", sustainabilityPoints: 80, price: 1.0), count: 1)]
    
    var product: Product
    var count: Int
    var id = UUID()
    
}
