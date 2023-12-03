//
//  DetailViewController.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 24/11/23.
//

import UIKit

class DetailProductViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    var cartViewModel = ShoppingCartViewModel()
    let loadingView = LoadingView()
    
 
    let headerId = "headerId"
    let detailID = "sizeId"
    
    var detailProduct: Product? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detalhe do produto"
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(cartButtonTapped))
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(DetailHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(DetailSelectedProductViewCell.self, forCellWithReuseIdentifier: detailID)
        setupUI()
    }
    
    @objc func cartButtonTapped() {
        let vc = ShoppingCartViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupUI() {
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loadingView.stopLoading()
    }
}

extension DetailProductViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailID, for: indexPath) as! DetailSelectedProductViewCell
        cell.delegate = self
        cell.detailProduct = self.detailProduct
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = UIScreen.main.bounds.width
        var height: CGFloat = 100
        
        let cell = DetailSelectedProductViewCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
        cell.detailProduct = self.detailProduct
        cell.layoutIfNeeded()
        
        let sizeEstimate = cell.systemLayoutSizeFitting(CGSize(width: width, height: 1000))
        height = sizeEstimate.height
        
        return .init(width: width, height: height)
    }
}

extension DetailProductViewController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DetailHeaderReusableView
        header.detailProduct = self.detailProduct
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.height * 0.6)
    }
}

extension DetailProductViewController: DetailSelectedProductDelegate {
    
    func buttonTappedPay(item: Product) {
        loadingView.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.cartViewModel.removeAllCart()
            let vc = PaymentSuccessViewController()
            vc.paymentProduct = item
            self.navigationController?.pushViewController(vc, animated: true)
            self.loadingView.stopLoading()
        }
    }
    
    func buttonTappedAddCart(item: Product) {
        loadingView.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.cartViewModel.addToCart(product: item, quantity: 1)
            self.loadingView.stopLoading()
        }
    }
}
