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
    
    /*
     •    products → API’den gelen ürünleri tutan liste.
     •    private → dışarıdan direkt erişilmesin, sadece bu sınıfta yönetilsin.
     •    didSet → products değiştiğinde otomatik çalışır.
     •    self.reloadTableView?() → bir closure çağırır (yani View’a haber verir).
     •    Örn: “Ürünler güncellendi, TableView’i yenile!”
     */
    
    var reloadTableView: (() -> Void)?
    
    /*
     •    Bu bir closure property.
     •    ViewController, bunu doldurur → “Veri geldiğinde ne yapılacağını” söyler.
     •    Bizim durumda: TableView’i reload etmek için kullanıyoruz.
     */
    
    var numberOfRows: Int {
        // TableView’e satır sayısını verir, kaç ürün varsa o kadar satır olacak.
        return products.count
    }
    
    func product(at index: Int) -> Product {
        // Verilen sıradaki ürünü döner, TableView’in hücrelerinde hangi ürün gösterilecekse buradan alınır.
        return products[index]
    }
    
    func fetchProducts() {
        APIService.shared.fetchProducts { [weak self] result in
            
            /*
             •    fetchProducts() → API’den ürünleri çeker.
             •    APIService.shared.fetchProducts → Network isteği yapar.
             */
        
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
