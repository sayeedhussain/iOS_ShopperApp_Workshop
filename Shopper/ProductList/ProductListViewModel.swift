protocol ProductListViewModel {
    func getProducts(completion: () -> Void)
}

class ProductListViewModelImpl: ProductListViewModel {
    
    private let respository: ProductRepository
    private var products: [Product] = []
    
    init(repository: ProductRepository = ProductRepositoryImpl()) {
        self.respository = repository
    }
    
    func getProducts(completion: () -> Void) {
        products = []
        respository.getProducts(completion: { [weak self] products in
            self?.products = products
            completion()
        }, error: { error in
            print(error);
        })
    }
}
