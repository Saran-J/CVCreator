import Foundation
import UIKit

class AlertBuilder {
    let alert = UIAlertController()
    
    func setTitle(title: String) -> AlertBuilder {
        alert.title = title
        return self
    }
    
    func setMessage(message: String) -> AlertBuilder {
        alert.message = message
        return self
    }
    
    func addPositiveButton(title: String, handler: ((UIAlertAction) -> Void)? = nil) -> AlertBuilder {
        let action = UIAlertAction(title: title, style: .default, handler: handler)
        alert.addAction(action)
        return self
    }
    
    func addNegativeButton(title: String, handler: ((UIAlertAction) -> Void)? = nil) -> AlertBuilder {
        let action = UIAlertAction(title: title, style: .cancel, handler: handler)
        alert.addAction(action)
        return self
    }
    
    func build() -> UIAlertController {
        return alert
    }
}
