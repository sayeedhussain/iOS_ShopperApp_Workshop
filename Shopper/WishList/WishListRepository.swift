protocol WishListRepository {
    func loadWishList()
    func updateWishList(product: Product, quantity: Int)
    func quantity(for product: Product) -> Int
}

class WishListRepositoryImpl: WishListRepository {
    
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
        
        var itemIndex = -1
       
        for (index, item) in wishList.items.enumerated() {
            if item.product == product {
                itemIndex = index
            }
        }
        
        if itemIndex == -1 {
            wishList.items.append(WishListItem(product: product, quantity: 1))
        } else {
            var wishListItem = wishList.items[itemIndex]
            wishListItem.quantity = quantity
            wishList.items[itemIndex] = wishListItem
        }
        
        persister.save(wishList: wishList)
    }
    
    func quantity(for product: Product) -> Int {
        guard let wishListItem = wishList.items.first(where: { (item) -> Bool in
            item.product == product
        }) else {
            return 0
        }
        return wishListItem.quantity
    }
}
