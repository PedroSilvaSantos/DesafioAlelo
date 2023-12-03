//
//  CardBuyTableViewCell.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 28/11/23.
//

import UIKit

class ShoppingCartTableViewCell: UITableViewCell {

    static let identifier: String = "cellID"
    var shoppingCartItem: ShoppingCartItem?
    var productListViewController = ProductListViewController()
    
    
    weak var delegate: ShoppingCartTableViewDelegate?
    
    private let imagemView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameTextoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceTextoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let installmentTextoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let corTextoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        button.setTitleColor(.green, for: .normal)
        return button
    }()
    
    let trashButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "trash"), for: .normal)
        button.addTarget(self, action: #selector(didTapTrashButton), for: .touchUpInside)
        button.setTitleColor(.green, for: .normal)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurarCela()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurarCela() {
        self.contentView.addSubview(imagemView)
        self.contentView.addSubview(nameTextoLabel)
        self.contentView.addSubview(priceTextoLabel)
        self.contentView.addSubview(installmentTextoLabel)
        self.contentView.addSubview(corTextoLabel)
        
        self.contentView.addSubview(minusButton)
        self.contentView.addSubview(countLabel)
        self.contentView.addSubview(plusButton)
        self.contentView.addSubview(trashButton)
        
        NSLayoutConstraint.activate([
            imagemView.topAnchor.constraint(equalTo: topAnchor),
            imagemView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imagemView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imagemView.widthAnchor.constraint(equalToConstant: 90),
            imagemView.heightAnchor.constraint(equalToConstant: 100),
            
            nameTextoLabel.topAnchor.constraint(equalTo: imagemView.topAnchor, constant: 30),
            nameTextoLabel.leadingAnchor.constraint(equalTo: imagemView.trailingAnchor, constant: 8),
            
            priceTextoLabel.leadingAnchor.constraint(equalTo: imagemView.trailingAnchor, constant: 8),
            priceTextoLabel.topAnchor.constraint(equalTo: nameTextoLabel.bottomAnchor, constant: 8),
            
            installmentTextoLabel.leadingAnchor.constraint(equalTo: imagemView.trailingAnchor, constant: 8),
            installmentTextoLabel.topAnchor.constraint(equalTo: priceTextoLabel.bottomAnchor, constant: 8),
            
            corTextoLabel.leadingAnchor.constraint(equalTo: imagemView.trailingAnchor, constant: 8),
            corTextoLabel.topAnchor.constraint(equalTo: installmentTextoLabel.bottomAnchor, constant: 8),
            
            minusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            minusButton.topAnchor.constraint(equalTo: corTextoLabel.bottomAnchor, constant: 20),
            
            countLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 12),
            countLabel.centerYAnchor.constraint(equalTo: minusButton.centerYAnchor),
            
            plusButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 12),
            plusButton.centerYAnchor.constraint(equalTo: minusButton.centerYAnchor),
            
            trashButton.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            trashButton.centerYAnchor.constraint(equalTo: minusButton.centerYAnchor),
            trashButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with item: ShoppingCartItem) {
        nameTextoLabel.text = item.product.name
        priceTextoLabel.text = item.product.actualPrice
        installmentTextoLabel.text = item.product.installments
        corTextoLabel.text = item.product.color
        countLabel.text = String(item.quantity)
        
        DownloaderImageProduct.downloadImage(from: item.product.image) { (image) in
            if let image = image {
                DispatchQueue.main.async {
                    self.imagemView.image = image
                }
            } else {
                self.imagemView.image = UIImage(named: "indisponivel")
            }
        }
    }
    
    @objc func didTapTrashButton() {
        delegate?.didTapTrashButton()
    }
    
    @objc func didTapMinusButton() {
        if let item = shoppingCartItem {
            delegate?.didTapMinusButton(forItem: item)
        }
    }
    
    @objc func didTapPlusButton() {
        if let item = shoppingCartItem {
            delegate?.didTtapPlusButton(forItem: item)
        }
    }
}
