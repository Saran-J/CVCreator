import UIKit

class HeaderView: UITableViewHeaderFooterView {
    static let identifier = "HeaderView"
    
    var onEditButton: (() -> ()) = {}
    @IBOutlet weak var title: UILabel!
    
    @IBAction func onEdit() {
        self.onEditButton()
    }
}
