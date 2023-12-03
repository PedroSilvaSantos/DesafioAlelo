//
//  NumberOfItemsIncluded.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 02/12/23.
//

import Foundation


protocol ProtocolNumberOfItemsIncluded: AnyObject {
    func updateCartItemCount(newCount: Int)
}

protocol ShoppingCartTableViewDelegate: AnyObject {
    func didTapTrashButton()
    func didTapMinusButton(forItem item: ShoppingCartItem)
    func didTtapPlusButton(forItem item: ShoppingCartItem)
}
