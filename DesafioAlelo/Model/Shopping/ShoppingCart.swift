//
//  ShoppingCart.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 22/11/23.
//

import UIKit


class ShoppingCart {
    
    var items: [ShoppingCartItem] {
        get {
            if let data = UserDefaults.standard.data(forKey: "shoppingCartItems"),
               let decodedItems = try? JSONDecoder().decode([ShoppingCartItem].self, from: data) {
                return decodedItems
            }
            return []
        }
        set {
            if let encodedData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: "shoppingCartItems")
            }
        }
    }
    
    private func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: "shoppingCartItems")
        }
    }
    
    
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
        saveItems()
    }
    
    func removeItem(product: Product) {
        items.removeAll { $0.product.id == product.id }
        saveItems()
    }
    
    func calculateTotalItems() -> Double {
        guard !items.isEmpty else { return 0.0 }
        return items.reduce(0.0) { $0 + $1.totalPrice}
    }
}
