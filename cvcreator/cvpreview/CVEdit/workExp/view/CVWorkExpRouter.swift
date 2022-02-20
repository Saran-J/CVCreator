import Foundation

class CVWorkExpRouter {
    weak var viewController: CVWorkExpViewController?
    
    func presentEditWorkExp(index: Int, data: WorkExperience? = nil) {
        guard let vc = CVWorkExpEditViewController.initFromStoryboard() else { return }
        vc.setCallback(viewController)
        vc.index = index
        viewController?.present(vc, animated: true, completion: {
            if let data = data {
                vc.setExistingData(data: data)
            }
        })
    }
}
