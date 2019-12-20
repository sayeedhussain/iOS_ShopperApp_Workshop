
import UIKit

class ProductListViewController: UIViewController {

    let viewModel: ProductListViewModel = ProductListViewModelImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProducts()
    }

    func getProducts() {
        viewModel.getProducts {
            
        }
    }

}

