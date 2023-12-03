//
//  DetalheHeaderView.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 26/11/23.
//

import UIKit

class DetailHeaderReusableView: UICollectionReusableView {
    
    var detailProduct: Product? {
        didSet {
            if let detailProduct = detailProduct {
                DownloaderImageProduct.downloadImage(from: detailProduct.image) { (image) in
                    if let image = image {
                        DispatchQueue.main.async {
                            self.productPhotoImageView.image = image
                        }
                    } else {
                        self.productPhotoImageView.image = UIImage(named: "indisponivel")
                    }
                }
            }
        }
    }
    
    let productPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIheader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIheader() {
        
        addSubview(productPhotoImageView)
        
        NSLayoutConstraint.activate([
            productPhotoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            productPhotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productPhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productPhotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
}
