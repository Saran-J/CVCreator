import UIKit

extension CVDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cvModel?.email == nil ? 0 : 1
        case 1:
            return cvModel?.address == nil ? 0 : 1
        case 2:
            return cvModel?.careerObjective == nil ? 0 : 1
        case 3:
            return cvModel?.workExperience?.count ?? 0
        case 4:
            return cvModel?.skill?.count ?? 0
        case 5:
            return cvModel?.education?.count ?? 0
        case 6:
            return cvModel?.project?.count ?? 0
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createCVDataCell(tableView: tableView,
                                indexPath: indexPath,
                                model: self.cvModel)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: HeaderView.identifier
        ) as? HeaderView else {
            return HeaderView()
        }
        if header.backgroundView == nil {
            header.backgroundView = UIView(frame: header.bounds)
            header.backgroundView?.backgroundColor = UIColor(hex: "ECECEC")
        }
        header.title.text = generateHeaderTitle(section: section)
        header.onEditButton = { [weak self] in
            self?.onEditHeaderTap(section: section)
        }
        return header
    }
    
    func createCVDataCell(tableView: UITableView,
                         indexPath: IndexPath,
                         model: CVModel?) -> UITableViewCell {
        let cellId = generateCellId(section: indexPath.section)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
            return UITableViewCell()
        }
        generateCellData(cell: cell, indexPath: indexPath, model: model)
        
        
        return cell
    }
    
    private func generateHeaderTitle(section: Int) -> String {
        let title: String = {
            switch section {
            case 0:
                return "Basic Information"
            case 1:
                return "Address"
            case 2:
                return "Career Objective"
            case 3:
                if let exp = cvModel?.workExperience {
                    let duration = viewModel.calculcateWorkExpTotalDuration(workExp: exp)
                    return "Work Summary: \(duration.year) years \(duration.month) months"
                }
                return "Work Summary"
            case 4:
                return "Skills"
            case 5:
                return "Education Details"
            case 6:
                return "Project Details"
            default:
                return ""
            }
        }()
        return title
    }
    
    private func generateCellId(section: Int) -> String {
        let cellId: String = {
            switch section {
            case 0:
                return CVImageCell.identifier
            case 1:
                return CVInformationCell.identifier
            case 2:
                return CVInformationCell.identifier
            case 3:
                return CVWorkExperienceCell.identifier
            case 4:
                return CVInformationCell.identifier
            case 5:
                return CVEducationCell.identifier
            case 6:
                return CVProjectCell.identifier
            default:
                return CVInformationCell.identifier
            }
        }()
        return cellId
    }
    
    private func onEditHeaderTap(section: Int) {
        switch section {
        case 0:
            let data = Data.init(base64Encoded: cvModel?.photo ?? "") ?? Data()
            let image = UIImage(data: data)
            router.presentEditBasicInformation(
                name: cvModel?.name,
                email: cvModel?.email,
                phone: cvModel?.mobileNo,
                image: image)
        case 1:
            router.presentEditInformation(type: .address,
                                          oldValue: cvModel?.address)
        case 2:
            router.presentEditInformation(type: .careerObjective,
                                          oldValue: cvModel?.careerObjective)
        case 3:
            router.presentEditWorkExp(workExps: cvModel?.workExperience)
        case 4:
            router.presentEditSkill(skill: cvModel?.skill)
        case 5:
            router.presentEditEducation(educations: cvModel?.education)
        case 6:
            router.presentEditProject(projects: cvModel?.project)
        default: break
        
        }
    }
    
    func generateCellData(cell: UITableViewCell, indexPath: IndexPath, model: CVModel?) {
        switch indexPath.section {
        case 0:
            let personalCell = cell as? CVImageCell
            personalCell?.setData(name: model?.name ?? "",
                                  email: model?.email ?? "",
                                  phone: model?.mobileNo ?? "",
                                  image: model?.photo ?? nil)
        case 1:
            let addressCell = cell as? CVInformationCell
            addressCell?.label.text = model?.address ?? "no data"
        case 2:
            let objectiveCell = cell as? CVInformationCell
            objectiveCell?.label.text = model?.careerObjective ?? "no data"
        case 3:
            let workExpCell = cell as? CVWorkExperienceCell
            workExpCell?.setData(data: (cvModel?.workExperience ?? [])[indexPath.row])
        case 4:
            let skillCell = cell as? CVInformationCell
            skillCell?.label.text = (model?.skill ?? ["no data"])[indexPath.row]
        case 5:
            let educationCell = cell as? CVEducationCell
            educationCell?.setData(data: (cvModel?.education ?? [])[indexPath.row])
        case 6:
            let projectCell = cell as? CVProjectCell
            projectCell?.setData(data: (cvModel?.project ?? [])[indexPath.row])
        default:
            break
        }
    }
}
