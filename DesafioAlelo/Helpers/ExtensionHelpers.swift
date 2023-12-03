//
//  ExtensionHelpers.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 22/11/23.
//

import Foundation

extension Data {
    public func dataToModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
    
    public func toJson() -> [String: Any]? {
        return try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String: Any]
    }
}

