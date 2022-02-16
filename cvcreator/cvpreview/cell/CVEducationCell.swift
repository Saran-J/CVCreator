//
//  CVEducationCell.swift
//  cvcreator
//
//  Created by KTB_User on 17/2/2565 BE.
//

import UIKit

class CVEducationCell: UITableViewCell {

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

}
