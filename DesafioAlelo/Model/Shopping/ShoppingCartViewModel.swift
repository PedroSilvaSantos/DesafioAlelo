//
//  ShoppingCartViewModel.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 22/11/23.
//

import Foundation

class ShoppingCartViewModel {
    
    var shoppingCart = ShoppingCart()
    
    func addToCart(product: Product, quantity: Int) {
        shoppingCart.addItem(product: product, quantity: quantity)
    }
    
    func removeFromCart(product: Product) {
        shoppingCart.removeQuantity(of: product, quantity: 1)
    }
    
    func removeAllCart() {
        shoppingCart.items.removeAll()
    }
    
    func totalItemsInCart() -> Int {
        return shoppingCart.items.reduce(0) { $0 + $1.quantity }
    }

}
