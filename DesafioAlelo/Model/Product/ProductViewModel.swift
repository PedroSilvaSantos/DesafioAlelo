//
//  ProductViewModel.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 22/11/23.
//

import UIKit

protocol ProductViewModelDelegate {
    func success()
    func fail()
}

class ProductViewModel {
    
    private var listProducts: [Product]?
    private var delegate:ProductViewModelDelegate?
    
    public func delegate(delegate:ProductViewModelDelegate?) {
        self.delegate = delegate
    }
    
    init() {
        self.fetchProductsAll()
    }
        
    func fetchProductsAll() {
        guard let url = URL(string: "https://run.mocky.io/v3/963c8527-4b08-44e9-b607-dd8721f2bb1d") else { return }
        APIClient.shared.fetchProducts(from: url) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.sync {
                    self.listProducts = data
                    self.delegate?.success()
                }
            case .failure: break
                self.delegate?.fail()
            }
        }
    }

    var numberOfRowsInProducts: Int {
        return listProducts?.count ?? 0
    }
    
    public func loadProducts(indexPath: IndexPath) -> Product? {
        return self.listProducts?[indexPath.row]
    }
}

