//
//  APIService.swift
//  ShopClosureBindingApp
//
//  Created by Beyza Zengin on 27.09.2025.
//

import Foundation

final class APIService {
    static let shared = APIService()
    private init() {}
    
    private let baseURL = "https://api.escuelajs.co/api/v1/products"
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
