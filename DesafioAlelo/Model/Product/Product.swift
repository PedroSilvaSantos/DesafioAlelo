//
//  Product.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 22/11/23.
//
import Foundation

struct ProductList: Model {
    let products: [Product]
}

struct Product: Model, Identifiable {
    let id = UUID()
    let name: String
    let style: String
    let codeColor: String
    let colorSlug: String
    let color: String
    let onSale: Bool
    let regularPrice: String
    let actualPrice: String
    let discountPercentage: String
    let installments: String
    let image: String
    let sizes: [Size]

    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case style
        case codeColor = "code_color"
        case colorSlug = "color_slug"
        case color
        case onSale = "on_sale"
        case regularPrice = "regular_price"
        case actualPrice = "actual_price"
        case discountPercentage = "discount_percentage"
        case installments
        case image
        case sizes
    }
}

// MARK: - Size
struct Size: Model {
    let available: Bool
    let size: String
    let sku: String
    
    init(available: Bool, size: String, sku: String) {
        self.available = available
        self.size = size
        self.sku = sku
    }
}
