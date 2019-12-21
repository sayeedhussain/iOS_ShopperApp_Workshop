struct WishListSummary {
    let items: String
    let totalSavings: String
    let totalCost: String
    
    init(items: Int, totalSavings: Double, totalCost: Double) {
        self.items = "\(items)"
        self.totalSavings = "$\(totalSavings)"
        self.totalCost = "$\(totalCost)"
    }
}
