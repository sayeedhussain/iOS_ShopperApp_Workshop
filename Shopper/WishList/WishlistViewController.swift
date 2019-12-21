
import UIKit

class WishlistViewController: UIViewController {

    @IBOutlet weak var items: UILabel!
    @IBOutlet weak var totalSavings: UILabel!
    @IBOutlet weak var totalCost: UILabel!

    let viewModel: WishListViewModel = WishListViewModelImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func loadData() {
        let wishListSummary = viewModel.summary()
        items.text = wishListSummary.items
        totalSavings.text = wishListSummary.totalSavings
        totalCost.text = wishListSummary.totalCost
    }
}

