//
//  PaymentSuccessViewController.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 26/11/23.
//

import UIKit

class PaymentSuccessViewController: UIViewController {
    
    private let imagemView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "sucesso")
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mensagemLabel: UILabel = {
        let label = UILabel()
        label.text = "Compra realizada com sucesso!"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sucesso"
        setupUI()
    }
    
    var paymentProduct: Product? {
        didSet {
            guard let _paymentProduct = paymentProduct?.name else {return}
            mensagemLabel.text = "Compra de um \(String(describing: _paymentProduct)) realizada com sucesso!"
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(imagemView)
        view.addSubview(mensagemLabel)
        
        NSLayoutConstraint.activate([
            imagemView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imagemView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            imagemView.heightAnchor.constraint(equalToConstant: 90),
            imagemView.widthAnchor.constraint(equalToConstant: 90),
            
            
            mensagemLabel.topAnchor.constraint(equalTo: imagemView.bottomAnchor, constant: 30),
            mensagemLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mensagemLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func retornarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

