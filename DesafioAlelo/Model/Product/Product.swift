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
    var id = UUID()
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.style = try container.decode(String.self, forKey: .style)
        self.codeColor = try container.decode(String.self, forKey: .codeColor)
        self.colorSlug = try container.decode(String.self, forKey: .colorSlug)
        self.color = try container.decode(String.self, forKey: .color)
        self.onSale = try container.decode(Bool.self, forKey: .onSale)
        self.regularPrice = try container.decode(String.self, forKey: .regularPrice)
        self.actualPrice = try container.decode(String.self, forKey: .actualPrice)
        self.discountPercentage = try container.decode(String.self, forKey: .discountPercentage)
        self.installments = try container.decode(String.self, forKey: .installments)
        self.image = try container.decode(String.self, forKey: .image)
        self.sizes = try container.decode([Size].self, forKey: .sizes)
        if let idString = try container.decodeIfPresent(String.self, forKey: .id),
           let uuid = UUID(uuidString: idString) {
            id = uuid
        }
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
