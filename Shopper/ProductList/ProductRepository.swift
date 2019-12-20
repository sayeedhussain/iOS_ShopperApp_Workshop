
protocol ProductRepository {
    func getProducts(completion: ([Product]) -> Void, error: (Error) -> ())
}

class ProductRepositoryImpl: ProductRepository {

    let productListService: ProductListService
    
    init(productListService: ProductListService = ProductListServiceImpl()) {
        self.productListService = productListService
    }
    
    func getProducts(completion: ([Product]) -> Void, error: (Error) -> ()) {
        productListService.getProducts(completion: completion, error: error)
    }
}
