import UIKit
import WebKit

class PDFPreviewViewController: UIViewController {

    var webview: WKWebView?
    var url: String?
    
    static func initFromStoryboard() -> PDFPreviewViewController? {
        return UIStoryboard.getViewController(name: "PDFPreview") as? PDFPreviewViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        webview = WKWebView(frame: self.view.bounds)
        view.addSubview(webview!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dst = URL(fileURLWithPath: NSTemporaryDirectory().appending("sample1.pdf"))
        let request = URLRequest(url: dst)
        webview?.load(request)
    }
}
