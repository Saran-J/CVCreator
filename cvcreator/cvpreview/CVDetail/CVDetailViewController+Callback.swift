import Foundation
import UIKit

protocol CVDetailCallback: AnyObject {
    func onUpdatePersonalInformation(name: String, email: String, phone: String, image: UIImage)
    func onUpdateSkill(skills: String)
    func onUpdateAddress(address: String)
    func onUpdateObjective(objective: String)
    func onUpdateProjectData(project: [Project])
    func onUpdateEducationData(education: [Education])
    func onUpdateWorkExpData(workExp: [WorkExperience])
}

extension CVDetailViewController: CVDetailCallback {
    func onUpdatePersonalInformation(name: String, email: String, phone: String, image: UIImage) {
        cvModel?.name = name
        cvModel?.email = email
        cvModel?.mobileNo = phone
        cvModel?.photo = viewModel.convertUIImageToNSData(image: image)
        tableView.reloadData()
    }
    
    func onUpdateSkill(skills: String) {
        cvModel?.skill = skills.components(separatedBy: ",")
        tableView.reloadData()
    }
    
    func onUpdateAddress(address: String) {
        cvModel?.address = address.isEmpty ? nil : address
        tableView.reloadData()
    }
    
    func onUpdateObjective(objective: String) {
        cvModel?.careerObjective = objective.isEmpty ? nil : objective
        tableView.reloadData()
    }
    
    func onUpdateProjectData(project: [Project]) {
        cvModel?.project = project
        tableView.reloadData()
    }
    
    func onUpdateEducationData(education: [Education]) {
        cvModel?.education = education
        tableView.reloadData()
    }
    
    func onUpdateWorkExpData(workExp: [WorkExperience]) {
        cvModel?.workExperience = workExp
        tableView.reloadData()
    }
}
