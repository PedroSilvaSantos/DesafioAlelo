//
//  ProductImageLoading.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 24/11/23.
//

import UIKit

class DownloaderImageProduct {
    static func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            if let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }

        task.resume()
    }
}
