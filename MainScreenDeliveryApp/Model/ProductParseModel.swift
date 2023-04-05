//
//  ProductParseModel.swift
//  MainScreenDeliveryApp
//
//  Created by Артем Манасян on 04.04.2023.
//

import Foundation


struct ProductParseModel: Codable {
    let product: [Product]
    
    enum CodingKeys: String, CodingKey {
        case product
    }
}

struct Product: Codable {
    let name: String
    let description: String
    let image: String
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case name, description, image, price
    }
}
