//
//  ProductDetailViewModel.swift
//  ShopClosureBindingApp
//
//  Created by Beyza Zengin on 27.09.2025.
//
import Foundation

final class ProductDetailViewModel {
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var title: String {
        return product.title
    }
    
    var description: String {
        return product.description
    }
    
    var priceText: String {
        return "$\(product.price)"
    }
    
    var imageURL: String {
        return product.images.first ?? ""
    }
}
