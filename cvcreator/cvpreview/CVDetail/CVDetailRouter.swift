import Foundation
import UIKit

class CVDetailRouter {
    weak var viewController: CVDetailViewController?
    
    func presentEditBasicInformation(name: String?, email: String?, phone: String?, image: UIImage?) {
        guard let vc = CVPersonalInfoViewController.initFromStoryboard() else { return }
        vc.setupCallback(viewController)
        
        viewController?.present(vc, animated: true, completion: {
            vc.setExistingData(name: name, email: email, phone: phone, image: image)
        })
    }
    
    func presentEditSkill(skill: [String]?) {
        guard let vc = CVSkillViewController.initFromStoryboard() else { return }
        vc.setupCallback(viewController)
        viewController?.present(vc, animated: true, completion: {
            vc.setupExisting(oldValue: skill?.joined(separator: ",") ?? "")
        })
    }
    
    func presentEditInformation(type: InformationType, oldValue: String?) {
        guard let vc = CVEditInformationViewController.initFromStoryboard() else { return }
        vc.setupCallback(viewController)
        vc.type = type
        viewController?.present(vc, animated: true, completion: {
            vc.setupExisting(oldValue: oldValue ?? "")
        })
    }
    
    func presentEditWorkExp(workExps: [WorkExperience]?) {
        guard let vc = CVWorkExpViewController.initFromStoryboard() else { return }
        vc.workExpData = workExps ?? []
        vc.setupCallback(viewController)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentEditEducation(educations: [Education]?) {
        guard let vc = CVEducationViewController.initFromStoryboard() else { return }
        vc.eduData = educations ?? []
        vc.setupCallback(viewController)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentEditProject(projects: [Project]?) {
        guard let vc = CVProjectViewController.initFromStoryboard() else { return }
        vc.projectData = projects ?? []
        vc.setupCallback(viewController)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentPDF() {
        guard let vc = PDFPreviewViewController.initFromStoryboard() else { return }
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
