//
//  Product.swift
//  ShopClosureBindingApp
//
//  Created by Beyza Zengin on 27.09.2025.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let slug: String
    let price: Int
    let description: String
    let category: Category
    let images: [String]
    let creationAt: String
    let updatedAt: String
}
