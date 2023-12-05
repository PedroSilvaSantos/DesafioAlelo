//
//  ShoppingCartViewController.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 01/12/23.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    private let tableView = UITableView()
    private let totalLabel = UILabel()
    private var cartViewModel = ShoppingCartViewModel()
    weak var delegateNumberOfItems: ProtocolNumberOfItemsIncluded?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Carrinho de compras"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupTableView()
        updateTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(ShoppingCartTableViewCell.self, forCellReuseIdentifier: ShoppingCartTableViewCell.identifier)
        tableView.register(FooterView.self, forHeaderFooterViewReuseIdentifier: FooterView.identifier)
    }
}


extension ShoppingCartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.identifier, for: indexPath) as? ShoppingCartTableViewCell
        let item = cartViewModel.shoppingCart.items[indexPath.row]
        cell?.delegate = self
        cell?.shoppingCartItem = item
        cell?.configure(with: item)
        
        return cell ?? UITableViewCell()
    }
    
    private func updateTableView() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterView.identifier) as? FooterView {
            footerView.totalFooter.text = "Total"
            footerView.valueFooter.text = String(format: "R$ %.2f", cartViewModel.shoppingCart.calculateTotalItems())
            return footerView
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = cartViewModel.shoppingCart.items[indexPath.row]
            cartViewModel.removeFromCart(product: item.product)
            tableView.reloadData()
        }
    }
}


extension ShoppingCartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartViewModel.shoppingCart.items.count
    }
}

extension ShoppingCartViewController: ShoppingCartTableViewDelegate {
    
    func didTapTrashButton() {
        DispatchQueue.main.async {
            self.cartViewModel.removeAllCart()
            self.updateTableView()
        }
    }
    
    func didTapMinusButton(forItem item: ShoppingCartItem) {
        DispatchQueue.main.async {
            self.cartViewModel.removeFromCart(product: item.product)
            self.updateTableView()
        }
    }
    
    func didTtapPlusButton(forItem item: ShoppingCartItem) {
        DispatchQueue.main.async {
            self.cartViewModel.addToCart(product: item.product, quantity: 1)
            self.updateTableView()
        }
    }
}

