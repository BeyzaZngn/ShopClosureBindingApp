//
//  ProductListViewModel.swift
//  ShopClosureBindingApp
//
//  Created by Beyza Zengin on 27.09.2025.
//

import Foundation

final class ProductListViewModel {
    
    private var products: [Product] = [] {
        didSet {
            self.reloadTableView?()
        }
    }
    
    var reloadTableView: (() -> Void)?
    
    var numberOfRows: Int {
        return products.count
    }
    
    func product(at index: Int) -> Product {
        return products[index]
    }
    
    func fetchProducts() {
        APIService.shared.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.products = products
                case .failure(let error):
                    print("❌ API Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
