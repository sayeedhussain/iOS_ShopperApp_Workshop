protocol ProductListCellViewModel {
    var name: String {get}
    var price: String {get}
    var offerPrice: String {get}
    var imageURL: String {get}
}

class ProductListCellViewModelImpl {
    
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
}

extension ProductListCellViewModelImpl: ProductListCellViewModel {
   
    var name: String {
        return product.name
    }
    
    var price: String {
        return product.price
    }
    
    var offerPrice: String {
        return product.offerPrice
    }
    
    var imageURL: String {
        return product.imageURL
    }
    
}
