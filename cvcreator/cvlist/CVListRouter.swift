import Foundation

class CVListRouter {
    weak var viewController: CVListViewController?
    
    func routeToEditCV(model: CVModel? = nil) {
        guard let vc = CVDetailViewController.initFromStoryboard() else { return }
        vc.setCallback(callback: viewController)
        if let model = model {
            vc.cvModel = model
        }
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
