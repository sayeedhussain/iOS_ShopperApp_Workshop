protocol WishListPersister {
    func save(wishList: WishList)
    func getWishList() -> WishList?
}

class WishListPersisterImpl: WishListPersister {

    private let keyValueStore: KeyValueStore
    private let storingKey = "WishList"
    
    init(keyValueStore: KeyValueStore = KeyValueStoreImpl()) {
        self.keyValueStore = keyValueStore
    }
    
    func getWishList() -> WishList? {
        return keyValueStore.value(for: storingKey)
    }
    
    func save(wishList: WishList) {
        _ = keyValueStore.setValue(value: wishList, forKey: storingKey)
    }
}

