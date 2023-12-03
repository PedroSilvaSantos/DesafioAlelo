//
//  DetailSizeView.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 26/11/23.
//

import UIKit

protocol DetailSizeViewDelegate: AnyObject {
    func buttonTappedPay()
}

class DetailOfTheSelectedProduct: UICollectionViewCell {
    
    weak var delegate: DetailSizeViewDelegate?
    
    var detailProduct: Product? {
        didSet {
            if let _detailProduct = detailProduct {
                sizeChoose.text = _detailProduct.name
                numberOfInstallments.text = _detailProduct.installments
            }
        }
    }
    
    let sizeChoose: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Escolha seu tamanho"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 2)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfInstallments: UILabel = {
        let label = UILabel()
        UIFont.boldSystemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    let availableStock: UILabel = {
        let label = UILabel()
        label.text = "Estoque disponivel"
        UIFont.boldSystemFont(ofSize: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    let chooseYourThemeP: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("P", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 104/255, alpha: 1)
        button.layer.cornerRadius = button.bounds.width / 2
        return button
    }()
    
    let chooseYourThemePP: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PP", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 104/255, alpha: 1)
        button.layer.cornerRadius = button.bounds.width / 2
        return button
    }()
    
    let chooseYourThemeM: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("M", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 104/255, alpha: 1)
        button.layer.cornerRadius = button.bounds.width / 2
        return button
    }()
    
    let chooseYourThemeG: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("G", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 104/255, alpha: 1)
        button.layer.cornerRadius = button.bounds.width / 2
        return button
    }()
    
    let chooseYourThemeGG: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GG", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 104/255, alpha: 1)
        button.layer.cornerRadius = button.bounds.width / 2
        return button
    }()
    
    let buyProduct: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Comprar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0/255, green: 168/255, blue: 104/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    let addToCart: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar ao carrinho", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 138/255, green: 215/255, blue: 186/255, alpha: 1)
        button.addTarget(DetailOfTheSelectedProduct.self, action: #selector(didTapPayButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    @objc
        private func didTapPayButton() {
            delegate?.buttonTappedPay()
        }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        
        let sizeChooseStackView = UIStackView(arrangedSubviews: [numberOfInstallments, availableStock, sizeChoose])
        
        sizeChooseStackView.spacing = 15
        sizeChooseStackView.axis = .vertical

        
        let stackView = UIStackView(arrangedSubviews: [sizeChooseStackView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        
        let buyProductStackView = UIStackView(arrangedSubviews: [buyProduct])
        let addToCartStackView = UIStackView(arrangedSubviews: [addToCart])
        
        buyProductStackView.translatesAutoresizingMaskIntoConstraints = false
        buyProductStackView.spacing = 10
        addToCartStackView.spacing = 10
        
        let stkbuyProductStackView = UIStackView(arrangedSubviews: [buyProductStackView])
        let stkaddToCartStackView = UIStackView(arrangedSubviews: [addToCartStackView])
        
        
        let sizeOptionStackView = UIStackView(arrangedSubviews: [chooseYourThemeP,chooseYourThemePP,chooseYourThemeM,chooseYourThemeG,chooseYourThemeGG])
        sizeOptionStackView.spacing = 8
        
        ///setupConstraints
        setupConstraints(stackView: stackView, sizeOptionStackView: sizeOptionStackView, stkbuyProductStackView: stkbuyProductStackView, stkaddToCartStackView: stkaddToCartStackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        sizeOptionStackView.translatesAutoresizingMaskIntoConstraints = false
        stkbuyProductStackView.translatesAutoresizingMaskIntoConstraints = false
        stkaddToCartStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: sizeOptionStackView.topAnchor, constant: -30),
        ])
        
        NSLayoutConstraint.activate([
            sizeOptionStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            sizeOptionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            sizeOptionStackView.bottomAnchor.constraint(equalTo: stkaddToCartStackView.topAnchor, constant: -50),
        ])
        
        NSLayoutConstraint.activate([
            stkaddToCartStackView.trailingAnchor.constraint(equalTo: stkbuyProductStackView.trailingAnchor),
            stkaddToCartStackView.leadingAnchor.constraint(equalTo: stkbuyProductStackView.leadingAnchor),
            stkaddToCartStackView.bottomAnchor.constraint(equalTo: stkbuyProductStackView.topAnchor, constant: -10),
            stkaddToCartStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            stkbuyProductStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stkbuyProductStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stkbuyProductStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            stkbuyProductStackView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

extension DetailOfTheSelectedProduct {
    
    func setupConstraints(stackView: UIStackView, sizeOptionStackView: UIStackView, stkbuyProductStackView: UIStackView, stkaddToCartStackView: UIStackView) {
        addSubview(stackView)
        addSubview(sizeOptionStackView)
        addSubview(stkbuyProductStackView)
        addSubview(stkaddToCartStackView)
    }
}
