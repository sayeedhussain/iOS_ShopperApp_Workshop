import Foundation

protocol ProductListViewModel {
    var productsCount: Int {get}
    func cellViewModel(at index: Int) -> ProductListCellViewModel
    func getProducts(completion: @escaping () -> Void)
}

class ProductListViewModelImpl: ProductListViewModel {
    
    private let respository: ProductRepository
    private var products: [Product] = []
    
    init(repository: ProductRepository = ProductRepositoryImpl()) {
        self.respository = repository
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
    
    var productsCount: Int {
        return products.count
    }
    
    func cellViewModel(at index: Int) -> ProductListCellViewModel {
        return ProductListCellViewModelImpl(product: products[index])
    }
}
