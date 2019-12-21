import Foundation
import UIKit

protocol ProductListCellViewModel {
    var name: String {get}
    var price: NSAttributedString {get}
    var imageURL: String {get}
    var qty: Double {get}
    func updateProduct(at index: Int, qty: Int)
}

protocol ProductListCellViewModelDelegate: class {
    func updateProduct(at index: Int, qty: Int)
}

class ProductListCellViewModelImpl {
    
    private let product: Product
    private let quantity: Int
    private weak var delegate: ProductListCellViewModelDelegate?

    init(product: Product,
         quantity: Int,
         delegate: ProductListCellViewModelDelegate) {
        self.product = product
        self.quantity = quantity
        self.delegate = delegate
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
    
    var qty: Double {
        return Double(quantity)
    }
    
    func updateProduct(at index: Int, qty: Int) {
        delegate?.updateProduct(at: index, qty: qty)
    }
}
