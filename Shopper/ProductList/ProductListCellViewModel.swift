import Foundation
import UIKit

protocol ProductListCellViewModel {
    var name: String {get}
    var price: NSAttributedString {get}
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
    
    var price: NSAttributedString {
        guard let offerPrice = product.offerPrice else {
            return NSAttributedString(string: product.price)
        }
        return NSAttributedString(string:offerPrice, attributes:
            [NSAttributedString.Key.foregroundColor: UIColor.orange])
    }
    
    var imageURL: String {
        return product.image
    }
    
}
