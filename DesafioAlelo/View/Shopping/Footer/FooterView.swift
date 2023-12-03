//
//  FooterView.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 02/12/23.
//

import UIKit

class FooterView: UITableViewHeaderFooterView {
    
    static let identifier: String = "footerViewIdentifier"
    
    let totalFooter: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueFooter: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.text = String(format: "R$ %.2f", label)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(totalFooter)
        addSubview(valueFooter)
        
        NSLayoutConstraint.activate([
            totalFooter.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            totalFooter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            valueFooter.centerYAnchor.constraint(equalTo: totalFooter.centerYAnchor),
            valueFooter.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
