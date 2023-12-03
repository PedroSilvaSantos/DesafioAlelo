//
//  ProductCollectionViewCell.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 22/11/23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    var viewModelCell: ProductCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubViews()
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var nameProduct: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var actualPriceProduct: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var regularPriceProduct: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        let atributos: [NSAttributedString.Key: Any] = [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue,
            .strikethroughColor: UIColor.gray,
        ]
        let oldPrice = NSAttributedString(string: "\u{0336}", attributes: atributos)
        label.attributedText = oldPrice
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var discountPercentageProduct: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var installmentsProduct: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageProductView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.borderColor = .init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        imageView.layer.cornerRadius = 10.0
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let colorStock: UILabel = {
        let label = UILabel()
        label.text = "Cor: Preto"
        UIFont.boldSystemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func addSubViews() {
        self.addSubview(imageProductView)
        self.addSubview(nameProduct)
        self.addSubview(actualPriceProduct)
        self.addSubview(regularPriceProduct)
        self.addSubview(discountPercentageProduct)
        self.addSubview(installmentsProduct)
        self.addSubview(separatorView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            //imageProductView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageProductView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageProductView.widthAnchor.constraint(equalToConstant: 200),
            imageProductView.heightAnchor.constraint(equalToConstant: 200),

            nameProduct.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameProduct.topAnchor.constraint(equalTo: imageProductView.bottomAnchor, constant: 20),

            actualPriceProduct.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            actualPriceProduct.topAnchor.constraint(equalTo: nameProduct.bottomAnchor, constant: 10),
            
            installmentsProduct.topAnchor.constraint(equalTo: actualPriceProduct.topAnchor),
            installmentsProduct.leadingAnchor.constraint(equalTo: actualPriceProduct.trailingAnchor, constant: 10),
            
            regularPriceProduct.topAnchor.constraint(equalTo: installmentsProduct.bottomAnchor, constant: 5),
            regularPriceProduct.leadingAnchor.constraint(equalTo: actualPriceProduct.leadingAnchor),
            
            discountPercentageProduct.topAnchor.constraint(equalTo: installmentsProduct.bottomAnchor, constant: 5),
            discountPercentageProduct.trailingAnchor.constraint(equalTo: installmentsProduct.trailingAnchor, constant: -10),
            separatorView.topAnchor.constraint(equalTo: bottomAnchor, constant: 8),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func configure(with product: Product) {
        viewModelCell = ProductCellViewModel(data: product)
        self.nameProduct.text = viewModelCell?.getNameProduct
        self.actualPriceProduct.text = viewModelCell?.getActualPrice
        self.installmentsProduct.text = viewModelCell?.getInstallments
        
        if let url = URL(string: viewModelCell!.getImageProduct) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.imageProductView.image = UIImage(data: data)
                }
            }
            task.resume()
        } else {
            self.imageProductView.image = UIImage(named: "indisponivel")
        }
        
        if self.viewModelCell?.getOnSale == true {
            self.regularPriceProduct.text = viewModelCell?.getRegularPrice
            self.discountPercentageProduct.text = viewModelCell?.getDiscountPercentage
        } else {
            self.regularPriceProduct.text = String()
            self.discountPercentageProduct.text = String()
        }
    }
}
