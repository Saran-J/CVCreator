import UIKit

class CVAddCell: UITableViewCell {

    static let identifier = "CVAddCell"
    @IBOutlet weak var addMoreButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
