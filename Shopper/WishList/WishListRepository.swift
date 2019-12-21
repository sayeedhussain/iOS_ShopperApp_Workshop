protocol WishListRepository {
    
    func loadWishList()
    func updateWishList(product: Product, quantity: Int)
    
    func quantity(for product: Product) -> Int
    func itemsCount() -> Int
    func totalSavings() -> Double
    func totalCost() -> Double
}

class WishListRepositoryImpl: WishListRepository {
    
    static let shared = WishListRepositoryImpl()
    
    private let persister: WishListPersister
    private var wishList: WishList = WishList(items: [])
    
    init(persister: WishListPersister = WishListPersisterImpl()) {
        self.persister = persister
        loadWishList()
    }
    
    func loadWishList() {
       wishList = persister.getWishList() ?? WishList(items: [])
    }
    
    func updateWishList(product: Product, quantity: Int) {
        
        let itemIndex = wishList.items.firstIndex { $0.product == product } ?? -1
        
        if itemIndex == -1 {
            wishList.items.append(WishListItem(product: product, quantity: 1))
        } else if quantity == 0 {
            wishList.items.remove(at: itemIndex)
        } else {
            var wishListItem = wishList.items[itemIndex]
            wishListItem.quantity = quantity
            wishList.items[itemIndex] = wishListItem
        }
        
        persister.save(wishList: wishList)
    }
    
    func quantity(for product: Product) -> Int {
        let wishListItem = wishList.items.first(where: { (item) -> Bool in
            item.product == product
        })
        return wishListItem?.quantity ?? 0
    }
    
    func itemsCount() -> Int {
        return wishList.items.reduce(0, {(acc, item) -> Int in
            return acc + item.quantity
        })
    }
    
    func totalCost() -> Double {
        return wishList.items.reduce(0.0, {(acc, item) -> Double in
            return acc + priceAsDouble(item.product.offerPrice ?? item.product.price) * Double(item.quantity)
        })
    }
    
    func totalSavings() -> Double {
        return wishList.items.reduce(0.0, {(acc, item) -> Double in
            let priceForItem = priceAsDouble(item.product.price)
            let offerPriceForItem = priceAsDouble(item.product.offerPrice ?? "0")
            let savingsForItem = offerPriceForItem == 0 ? 0 : priceForItem - offerPriceForItem
            let savingsForItemWithQty = savingsForItem * Double(item.quantity)
            return acc + savingsForItemWithQty
        })
    }
    
    private func priceAsDouble(_ price: String) -> Double {
        return Double(price.stringByRemovingAll(characters: ["$",","])) ?? 0
    }
}
