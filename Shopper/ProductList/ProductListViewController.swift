
import UIKit

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel: ProductListViewModel = ProductListViewModelImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: ProductListCell.NibName, bundle: nil), forCellReuseIdentifier: ProductListCell.CellIdentifier)
        getProducts()
    }

    func getProducts() {
        viewModel.getProducts {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListCell.CellIdentifier) as! ProductListCell
        let cellViewModel = viewModel.cellViewModel(at: indexPath.row)
        cell.configure(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

