//
//  ShoppingCartItem.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 22/11/23.
//

struct ShoppingCartItem: Model {
    var product: Product
    var quantity: Int
    
//    init(product: Product, quantity: Int) {
//        self.product = product
//        self.quantity = quantity
//    }
    
    static func == (lhs: ShoppingCartItem, rhs: ShoppingCartItem) -> Bool {
        return lhs.product == rhs.product && lhs.quantity == rhs.quantity
    }
    
    var totalPrice: Double {
        var total = Double()
        let priceString = product.actualPrice.replacingOccurrences(of: "R$", with: "").replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: " ", with: "")
        if let _actualPrice = Double(priceString) {
            total = _actualPrice * Double(quantity)
        }
        return total
    }
}




