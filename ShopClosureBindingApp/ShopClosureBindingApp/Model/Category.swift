//
//  Category.swift
//  ShopClosureBindingApp
//
//  Created by Beyza Zengin on 27.09.2025.
//

import Foundation

struct Category: Decodable {
    let id: Int
    let name: String
    let slug: String
    let image: String
    let creationAt: String
    let updatedAt: String
}
