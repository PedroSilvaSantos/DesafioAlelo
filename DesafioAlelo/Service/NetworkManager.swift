//
//  NetworkManager.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 22/11/23.
//

import Foundation

enum CustomError: Error {
    case networkError(String)
    case serverError(String)
    case invalidData
    case unauthorized
    case unexpected
    case errorParse
}

class APIClient {
    static let shared = APIClient()

    private init() {}

    func fetchProducts(from url: URL, completion: @escaping (Result<[Product]?, CustomError>) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard self != nil else { return }
            if error != nil {
                if let error = error as? NSError, error.domain == NSURLErrorDomain, error.code == -1003 {
                    completion(.failure(.networkError(String("Erro de host não encontrado"))))
                    return
                }
                completion(.failure(.invalidData))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                if let model: ProductList = data.dataToModel() {
                    completion(.success(model.products))
                } else {
                    completion(.failure(.errorParse))
                }
            } catch {
                completion(.failure(.unauthorized))
            }
        }.resume()
    }
}
