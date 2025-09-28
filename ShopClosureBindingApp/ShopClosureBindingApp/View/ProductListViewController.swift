//
//  ProductListViewController.swift
//  ShopClosureBindingApp
//
//  Created by Beyza Zengin on 27.09.2025.
//

import Foundation

import UIKit

final class ProductListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        
        tableView.dataSource = self // dataSource → tabloya kaç satır olacağını ve her satırın içeriğini ViewController sağlayacak.
        tableView.delegate = self // delegate → tablo satırına tıklandığında ne olacağını ViewController yönetecek.
        
        setupBinding() // setupBinding() → ViewModel ile View arasında bağ kuruyoruz.
        viewModel.fetchProducts() // viewModel.fetchProducts() → API çağrısını başlatıyoruz.
    }
    
    private func setupBinding() {
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    /*
     •    Burada Closure Binding yapıyoruz.
     •    ViewModel’de reloadTableView closure’ı vardı → burada doldurduk.
     •    Yani: “ViewModel’de veri değişirse, TableView’i yenile (reloadData)”.
     •    [weak self] → retain cycle (hafıza sızıntısı) olmasın diye.
     */
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    } // Tabloya kaç satır olacağını söyler, ViewModel’den alıyoruz (products.count).
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = viewModel.product(at: indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        /*
         •    dequeueReusableCell → TableView için önceden tanımlanmış hücreyi tekrar kullanır (performans için).
         •    "ProductTableViewCell" → storyboard’da verdiğimiz cell identifier.
         •    as? ProductTableViewCell → kendi custom cell’imize çeviriyoruz.
         •    Eğer cast başarısızsa → boş bir hücre döner.
         */
        
        cell.configure(with: product)
        return cell
        
        /*
         •    configure(with:) → ProductTableViewCell’de yazdığımız fonksiyon.
         •    Ürün bilgisini alır ve hücrede gösterir (resim, başlık, fiyat).
         •    Sonra hücreyi tabloya döneriz.
         */
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.product(at: indexPath.row)
        let detailVM = ProductDetailViewModel(product: product)
        
        /*
         •    Bir satıra tıklandığında çalışır.
         •    Tıklanan satırdaki ürünü buluruz.
         •    O ürün için yeni bir Detail ViewModel oluştururuz.
         */
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            detailVC.viewModel = detailVM
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
        /*
         •    UIStoryboard(name: "Main", bundle: nil) → Main.storyboard dosyasını açar.
         •    instantiateViewController(withIdentifier:) → ID’si "ProductDetailViewController" olan ekrandan yeni bir VC oluşturur.
         •    Eğer bu gerçekten bizim ProductDetailViewController sınıfımıza aitse:
         •    Ona detailVM atarız.
         •    navigationController?.pushViewController → yeni ekrana geçiş yaparız.
         */
    }
}
