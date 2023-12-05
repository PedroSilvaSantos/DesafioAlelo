//
//  Notification.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 02/12/23.
//

import Foundation

extension Notification.Name {
    static let updatedCart = Notification.Name("updatedCart")
}


class Manager {
    static let shared = Manager()
    
    var quantityInCart: Int = 0 {
        didSet {
            NotificationCenter.default.post(name: .updatedCart, object: nil)
        }
    }
    
    private init() {}
}
