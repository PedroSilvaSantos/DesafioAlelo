import UIKit

class ProductListViewController: UICollectionViewController {
    
    let cartButton = UIButton(type: .custom)
    var cartBarButton: UIBarButtonItem!
    var shoppingCartView = ShoppingCart()
    var productViewModel = ProductViewModel()
    var cartViewModel = ShoppingCartViewModel()
    var refreshControl = UIRefreshControl()
    
    
    let cartCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.red
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.isHidden = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTitleLabel()
        setupCart()
        navigationItem.title = "Categoria"
        setupRefreshControl()
    }
    
    private func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
        collectionView.layer.borderWidth = 1.0
        collectionView.layer.borderColor = UIColor.gray.cgColor
        collectionView.layer.cornerRadius = 8.0
        view.addSubview(collectionView)
        collectionView.addSubview(refreshControl)
    }
    
    var cartItemCount: Int = 0 {
        didSet {
            cartCountLabel.text = "\(cartItemCount)"
            cartCountLabel.isHidden = (cartItemCount == 0)
        }
    }
    
    private func setupCart() {
        cartButton.setImage(UIImage(named: "cart"), for: .normal)
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        cartBarButton = UIBarButtonItem(customView: cartButton)
        cartBarButton.customView?.addSubview(cartCountLabel)
        navigationItem.rightBarButtonItem = cartBarButton
        
        if let customView = cartBarButton.customView {
            NSLayoutConstraint.activate([
                cartCountLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: -15),
                cartCountLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor),
                cartCountLabel.widthAnchor.constraint(equalToConstant: 20),
                cartCountLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
    }
    
    @objc func cartButtonTapped() {
        let vc = ShoppingCartViewController()
        vc.delegateNumberOfItems = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
}

extension ProductListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productViewModel.numberOfRowsInProducts
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! ProductCollectionViewCell
        self.productViewModel.delegate(delegate: self)
        let product = productViewModel.loadProducts(indexPath: indexPath)!
        cell.configure(with: product)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedProduct = productViewModel.loadProducts(indexPath: indexPath) else {return}
        let vc = DetailProductViewController()
        vc.detailProduct = selectedProduct
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 12
        let height = CGFloat(300)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}


extension ProductListViewController: ProductViewModelDelegate {
    func success() {
        print("Lista carregado com sucesso!")
    }
    
    func fail() {
        print("Falha ao carregar a lista de produtos!")
    }
}


extension ProductListViewController {
    
    private func setupTitleLabel() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleLabel.text = "Categorias"
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension ProductListViewController {
    
    @objc func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.productViewModel.fetchProductsAll()
            self.refreshControl.endRefreshing()
        }
    }
}

extension ProductListViewController: ProtocolNumberOfItemsIncluded {
    
    func updateCartItemCount(newCount: Int) {
        cartItemCount = newCount
    }
}
