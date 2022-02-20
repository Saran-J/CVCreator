import UIKit

class CVEducationCell: UITableViewCell {

    static let identifier = "CVEduCell"
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var passingYearLabel: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: Education) {
        classLabel.text = "Class: \(data.eduClass)"
        passingYearLabel.text = "Passing Year: \(data.passingYear)"
        gpaLabel.text = "GPA: \(data.gpa)"
    }

}
