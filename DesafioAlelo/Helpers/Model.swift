//
//  Model.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 22/11/23.
//

import Foundation

public protocol Model: Codable, Equatable {}


public extension Model {
    func modelToData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
