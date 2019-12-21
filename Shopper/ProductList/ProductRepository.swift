
protocol ProductRepository {
    func getProducts(completion: @escaping ([Product]) -> Void, error: @escaping (Error) -> ())
}

class ProductRepositoryImpl: ProductRepository {

    let productListService: ProductListService
    
    init(productListService: ProductListService = ProductListServiceImpl()) {
        self.productListService = productListService
    }
    
    func getProducts(completion: @escaping ([Product]) -> Void, error: @escaping (Error) -> ()) {
        productListService.getProducts(completion: completion, error: error)
    }
}
