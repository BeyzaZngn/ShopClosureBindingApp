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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupBinding()
        viewModel.fetchProducts()
    }
    
    private func setupBinding() {
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ProductListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = viewModel.product(at: indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.product(at: indexPath.row)
        let detailVM = ProductDetailViewModel(product: product)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            detailVC.viewModel = detailVM
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
