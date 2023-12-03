//
//  ShoppingCart.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 22/11/23.
//

import UIKit


class ShoppingCart {
    
    var items: [ShoppingCartItem] = [ShoppingCartItem(product: Product(name: "VESTIDO TRANSPASSE BOW", style: "20002605", codeColor: "20002605_613", colorSlug: "tapecaria", color: "TAPEÇARIA", onSale: false, regularPrice: "R$ 199,90", actualPrice: "R$ 199,90", discountPercentage: "", installments: "3x R$ 66,63", image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912", sizes: [DesafioAlelo.Size(available: false, size: "PP", sku: "5807_343_0_PP")]), quantity: 1),ShoppingCartItem(product: Product(name: "VESTIDO TRANSPASSE BOW", style: "20002605", codeColor: "20002605_613", colorSlug: "tapecaria", color: "TAPEÇARIA", onSale: false, regularPrice: "R$ 199,90", actualPrice: "R$ 199,90", discountPercentage: "", installments: "3x R$ 66,63", image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912", sizes: [DesafioAlelo.Size(available: false, size: "PP", sku: "5807_343_0_PP")]), quantity: 1),ShoppingCartItem(product: Product(name: "VESTIDO TRANSPASSE BOW", style: "20002605", codeColor: "20002605_613", colorSlug: "tapecaria", color: "TAPEÇARIA", onSale: false, regularPrice: "R$ 199,90", actualPrice: "R$ 199,90", discountPercentage: "", installments: "3x R$ 66,63", image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912", sizes: [DesafioAlelo.Size(available: false, size: "PP", sku: "5807_343_0_PP")]), quantity: 1),ShoppingCartItem(product: Product(name: "VESTIDO TRANSPASSE BOW", style: "20002605", codeColor: "20002605_613", colorSlug: "tapecaria", color: "TAPEÇARIA", onSale: false, regularPrice: "R$ 199,90", actualPrice: "R$ 199,90", discountPercentage: "", installments: "3x R$ 66,63", image: "https://d3l7rqep7l31az.cloudfront.net/images/products/20002605_615_catalog_1.jpg?1460136912", sizes: [DesafioAlelo.Size(available: false, size: "PP", sku: "5807_343_0_PP")]), quantity: 1)]
    
    
    func addItem(product: Product, quantity: Int) {
        
        let existingItem = items.first { $0.product.id == product.id }
        
        if let existingItem = existingItem {
            let updatedItem = ShoppingCartItem(product: existingItem.product, quantity: existingItem.quantity + quantity)
            if let index = items.firstIndex(of: existingItem) {
                items[index] = updatedItem
            }
        } else {
            let newItem = ShoppingCartItem(product: product, quantity: quantity)
            items.append(newItem)
        }
    }
    
    func removeItem(product: Product) {
        items.removeAll { $0.product.id == product.id }
    }
    
    func calculateTotalItems() -> Double {
        guard !items.isEmpty else { return 0.0 }
        return items.reduce(0.0) { $0 + $1.totalPrice}
    }
    
//    func countSelectedProducts() -> Int {
//            let selectedItems = items.filter { $0.isSelected }
//            return selectedItems.count
//        }
}
