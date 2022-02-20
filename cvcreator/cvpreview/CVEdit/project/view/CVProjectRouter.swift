import Foundation

class CVProjectRouter {
    weak var viewController: CVProjectViewController?
    
    func presentEditProject(index: Int, data: Project? = nil) {
        guard let vc = CVProjectEditViewController.initFromStoryboard() else { return }
        vc.setCallback(viewController)
        vc.index = index
        
        viewController?.present(vc, animated: true, completion: {
            if let data = data {
                vc.setExistingData(data: data)
            }
        })
    }
}
