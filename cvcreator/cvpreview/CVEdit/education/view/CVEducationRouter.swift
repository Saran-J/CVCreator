import Foundation

class CVEducationRouter {
    weak var viewController: CVEducationViewController?
    
    func presentEditEducation(index: Int, data: Education? = nil) {
        guard let vc = CVEducationEditViewController.initFromStoryboard() else { return }
        vc.setCallback(viewController)
        vc.index = index
        viewController?.present(vc, animated: true, completion: {
            if let data = data {
                vc.setExistingData(data: data)
            }
        })
    }
}
