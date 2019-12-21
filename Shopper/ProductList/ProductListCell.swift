import UIKit


class ProductListCell: UITableViewCell {
   
    static let CellIdentifier = "ProductListCell"
    static let NibName = "ProductListCell"

    @IBOutlet weak var imgView: AsyncImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var qty: UILabel!

    func configure(with cellViewModel: ProductListCellViewModel) {
        name.text = cellViewModel.name
        price.attributedText = cellViewModel.price
        imgView.setURL(url: cellViewModel.imageURL)
    }
    
    @IBAction func onValueChanged(sender: Any) {
        qty.text = String(Int((sender as! UIStepper).value))
    }
}
