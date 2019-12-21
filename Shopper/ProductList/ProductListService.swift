import Foundation

protocol ProductListService {
    func getProducts(completion:@escaping ([Product]) -> Void, error: @escaping (Error) -> ())
}

class ProductListServiceImpl: ProductListService {
    
    private let networkClient: NetworkClient
    private let decoder: JSONDecoder
    
    init(networkClient: NetworkClient = NetworkClientImpl(),
         decoder: JSONDecoder = JSONDecoder()) {
        self.networkClient = networkClient
        self.decoder = decoder
    }
    
    func getProducts(completion: @escaping ([Product]) -> Void, error: @escaping (Error) -> ()) {
        
        let httpRequest = HttpRequest(method: .GET,
                                      url: "http://www.mocky.io/v2/5dfd9fdf310000ed1ac96dd7",
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
            return try decoder.decode([Product].self, from: data)
        } catch {
            print(error)
            return nil
        }        
    }
}
