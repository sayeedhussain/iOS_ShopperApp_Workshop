protocol WishListViewModel {
    func summary() -> WishListSummary
}

class WishListViewModelImpl: WishListViewModel {
    
    private let repository: WishListRepository
    
    init(repository: WishListRepository = WishListRepositoryImpl.shared) {
        self.repository = repository
    }
    
    func summary() -> WishListSummary {
        return WishListSummary(items: repository.itemsCount(),
                               totalSavings: repository.totalSavings(),
                               totalCost: repository.totalCost())
    }
}
