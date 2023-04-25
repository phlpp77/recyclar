//
//  ProductModel.swift
//  RecyclAR
//
//  Created by Philipp Hemkemeyer on 4/10/23.
//

import Foundation

struct Product: Identifiable {
    
    static var all: [Product] = [
        Product(name: "Barilla Penne", imageName: "cheerios", sustainabilityPoints: 80, price: 1.0),
        Product(name: "Barilla Penne", imageName: "cheerios", sustainabilityPoints: 80, price: 1.0),
        Product(name: "Barilla Penne", imageName: "cheerios", sustainabilityPoints: 80, price: 1.0),
        Product(name: "Barilla Penne", imageName: "cheerios", sustainabilityPoints: 80, price: 1.0),
        Product(name: "Coke", imageName: "pureLifeWater", sustainabilityPoints: 60, price: 1.49)
    ]
    
    var name: String
    var imageName: String
    var sustainabilityPoints: Int
    var price: Double
    var id = UUID()
}
