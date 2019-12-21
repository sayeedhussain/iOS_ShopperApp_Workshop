import UIKit


class ProductListCell: UITableViewCell {
   
    static let CellIdentifier = "ProductListCell"
    static let NibName = "ProductListCell"
    
    private var cellViewModel: ProductListCellViewModel!
    private var index: Int!
    
    @IBOutlet weak var imgView: AsyncImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var stepper: UIStepper!

    override func prepareForReuse() {
        qty.text = nil
    }
    
    func configure(with cellViewModel: ProductListCellViewModel, at index: Int) {
        self.cellViewModel = cellViewModel
        self.index = index
        name.text = cellViewModel.name
        qty.text = String(Int(cellViewModel.qty))
        stepper.value = cellViewModel.qty
        imgView.setURL(url: cellViewModel.imageURL)
        
        price.attributedText = cellViewModel.price
        offerPrice.attributedText = cellViewModel.offerPrice
    }
    
    @IBAction func onValueChanged(sender: Any) {
        let quantity = Int((sender as! UIStepper).value)
        cellViewModel.updateProduct(at: index, qty: quantity)
        qty.text = String(quantity)
    }
}
