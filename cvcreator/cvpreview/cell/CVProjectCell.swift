import UIKit

class CVProjectCell: UITableViewCell {

    static let identifier = "CVProjectCell"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var techLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: Project) {
        nameLabel.text = "Name: \(data.name)"
        sizeLabel.text = "Size: \(String(data.size))"
        summaryLabel.text = "Summary: \(data.summary)"
        techLabel.text = "Technology: \(data.techStack)"
        roleLabel.text = "Role: \(data.role)"
    }

}
