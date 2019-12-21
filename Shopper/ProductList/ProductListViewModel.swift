import Foundation

protocol ProductListViewModel {
    var productsCount: Int {get}
    func cellViewModel(at index: Int) -> ProductListCellViewModel
    func getProducts(completion: @escaping () -> Void)
}

class ProductListViewModelImpl: ProductListViewModel {
    
    private let respository: ProductRepository
    private let wishlistRepository: WishListRepository
    private var products: [Product] = []
    
    init(repository: ProductRepository = ProductRepositoryImpl(),
         wishlistRepository: WishListRepository = WishListRepositoryImpl.shared) {
        self.respository = repository
        self.wishlistRepository = wishlistRepository
    }
    
    var productsCount: Int {
        return products.count
    }

    func getProducts(completion: @escaping () -> Void) {
        products = []
        respository.getProducts(completion: { [weak self] products in
            self?.products = products
            completion()
        }, error: { error in
            print(error);
            completion()
        })
    }
    
    func cellViewModel(at index: Int) -> ProductListCellViewModel {
        let product = products[index]
        let quantity = wishlistRepository.quantity(for: product)
        return ProductListCellViewModelImpl(product: products[index],
                                            quantity: quantity,
                                            delegate: self)
    }
}

extension ProductListViewModelImpl: ProductListCellViewModelDelegate {
    func updateProduct(at index: Int, qty: Int) {
        let product = products[index]
        wishlistRepository.updateWishList(product: product, quantity: qty)
    }
}
