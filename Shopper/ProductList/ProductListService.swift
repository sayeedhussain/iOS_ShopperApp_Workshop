import Foundation

protocol ProductListService {
    func getProducts(completion:@escaping ([Product]) -> Void, error: @escaping (Error) -> ())
}

class ProductListServiceImpl: ProductListService {
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClientImpl()) {
        self.networkClient = networkClient
    }
    
    func getProducts(completion: @escaping ([Product]) -> Void, error: @escaping (Error) -> ()) {
        
        let httpRequest = HttpRequest(method: .GET,
                                      url: "http://www.mocky.io/v2/5dfb59e72f00006200ff9e80",
                                      body: nil,
                                      headers: nil)
        
        networkClient.performRequest(httpRequest) { httpResult in
            switch httpResult {
            case .failure(let err):
                error(err)
            case .success(let data):
                guard let products = self.parseProductsResponse(data: data) else {
                    error(NSError(error: "Parsing Error"))
                    return
                }
                completion(products)
            }
        }
    }
    
    private func parseProductsResponse(data: Data) -> [Product]? {
        do {
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            print(error)
            return nil
        }        
    }
}
