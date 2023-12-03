//
//  ProductCellViewModel.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 23/11/23.
//

import UIKit

enum DescriptionCustomCell: String {
    case cifrao = "$"
    case discount = " OFF"
}

class ProductCellViewModel {
    
    private var data: Product
    
    init(data: Product) {
        self.data = data
    }
    
    public var getNameProduct: String {
        return self.data.name
    }
    
    public var getActualPrice: String {
        return self.data.actualPrice
    }
    
    public var getRegularPrice: String {
        return self.data.regularPrice
    }
    
    public var getImageProduct: String {
        return self.data.image
    }
    
    public var getOnSale: Bool {
        return self.data.onSale
    }
    
    public var getDiscountPercentage: String {
        if self.data.onSale == true {
            return ("(" + self.data.discountPercentage + DescriptionCustomCell.discount.rawValue + ")")
        }
        return ""
    }
    
    public var getInstallments: String {
        return self.data.installments
    }
    
    public var getColor: String {
        return self.data.color
    }
    
    
    func configureSizes(with viewModel: ProductViewModel) {
       //TODO
    }
}
