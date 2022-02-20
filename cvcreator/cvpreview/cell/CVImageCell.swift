import UIKit

class CVImageCell: UITableViewCell {
    
    static let identifier = "CVImageCell"

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(name: String, email: String, phone: String, image: String?) {
        nameLabel.text = "Name: \(name)"
        emailLabel.text = "Email: \(email)"
        phoneLabel.text = "Phone: \(phone)"
        if let image = image {
            let data = Data(base64Encoded: image) ?? Data()
            let image = UIImage(data: data)
            imageProfile.image = image
        }
    }

}
