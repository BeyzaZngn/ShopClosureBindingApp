//
//  ProductTableViewCell.swift
//  ShopClosureBindingApp
//
//  Created by Beyza Zengin on 27.09.2025.
//

import Foundation

import UIKit

final class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
    }
    
    /*
     •    awakeFromNib() → hücre storyboard’dan yüklendiğinde bir kere çalışır.
     •    productImageView.contentMode = .scaleAspectFill → resim kırpılmadan, kutuyu dolduracak şekilde gösterilsin.
     •    clipsToBounds = true → resim kutunun dışına taşarsa kesilsin.
     */
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
        
        if let url = URL(string: product.images.first ?? "") {
            loadImage(from: url)
        }
    }
    
    /*
     •    configure(with:) → hücreye bir Product verildiğinde çalışır.
     •    titleLabel.text = product.title → ürün adı yazılır.
     •    priceLabel.text = "$\(product.price)" → ürün fiyatı yazılır.
     •    product.images.first → ürünün ilk resmi alınır (boş olabilir, o yüzden ?? "" ile boş string fallback veriyoruz).
     •    Eğer geçerli bir URL varsa → resmi internetten yüklemek için loadImage(from:) çağrılır.
     */
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.productImageView.image = image
                }
            }
        }.resume()
    }
    
    /*
     •    loadImage(from:) → internetten resmi indirir ve ekranda gösterir.
     •    URLSession.shared.dataTask(with:) → verilen URL’den resmi indirir.
     •    data → gelen ham resim verisi.
     •    UIImage(data:) → gelen veriden görsel oluşturulur.
     */
}

