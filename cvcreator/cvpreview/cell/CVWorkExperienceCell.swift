import UIKit

class CVWorkExperienceCell: UITableViewCell {

    static let identifier = "CVWorkExpCell"
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: WorkExperience) {
        companyLabel.text = "Company: \(data.companyName)"
        durationLabel.text = "Duration: \(data.duration.year) Years and \(data.duration.month) Months"
    }

}
