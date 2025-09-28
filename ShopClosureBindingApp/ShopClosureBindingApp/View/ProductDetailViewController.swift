//
//  ProductDetailViewController.swift
//  ShopClosureBindingApp
//
//  Created by Beyza Zengin on 27.09.2025.
//

import Foundation

import UIKit

final class ProductDetailViewController: UIViewController {
    

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    var viewModel: ProductDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() // Burada setupUI() fonksiyonunu çağırıyoruz → UI elemanlarını dolduracağız.
    }
    
    private func setupUI() {
        guard let vm = viewModel else { return }
        // guard let vm = viewModel → ViewModel boşsa (nil), hiçbir şey yapmadan çık.
        // Eğer ViewModel varsa, vm değişkenine atıyoruz.
        
        // ViewModel’den gelen verileri ekrandaki UI bileşenlerine aktarıyoruz:
        titleLabel.text = vm.title
        priceLabel.text = vm.priceText
        descriptionLabel.text = vm.description
        
        
        /*
         ViewModel’den gelen imageURL metnini URL tipine dönüştürüyoruz.
         Eğer geçerli bir URL ise → loadImage fonksiyonunu çağırıyoruz.
         */
        if let url = URL(string: vm.imageURL) {
            loadImage(from: url)
        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.productImageView.image = image
                }
            }
        }.resume()
    }
    
    /*
     •    loadImage(from:) → internetten resmi indirip ekranda gösterir.
     •    URLSession.shared.dataTask → asenkron şekilde resmi indirir.
     •    data → gelen ham veri.
     •    UIImage(data:) → ham veriden resim oluşturur.
     */
}
