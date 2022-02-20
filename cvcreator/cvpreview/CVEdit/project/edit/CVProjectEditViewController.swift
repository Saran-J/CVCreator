import UIKit

class CVProjectEditViewController: UIViewController {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var sizeTextfield: UITextField!
    @IBOutlet weak var summaryTextfield: UITextField!
    @IBOutlet weak var techStackTextfield: UITextField!
    @IBOutlet weak var roleTextfield: UITextField!
    
    weak var callback: CVProjectCallback?
    var index: Int = -1
    static func initFromStoryboard() -> CVProjectEditViewController? {
        return UIStoryboard.getViewController(name: "CVProjectEdit") as? CVProjectEditViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setCallback(_ callback: CVProjectCallback?) {
        self.callback = callback
    }
    
    func setExistingData(data: Project) {
        nameTextfield.text = data.name
        sizeTextfield.text = String(data.size)
        summaryTextfield.text = data.summary
        techStackTextfield.text = data.techStack
        roleTextfield.text = data.role
    }
    
    @IBAction func onSave() {
        let name = nameTextfield.text ?? ""
        let size = sizeTextfield.text ?? ""
        let summary = summaryTextfield.text ?? ""
        let techStack = techStackTextfield.text ?? ""
        let role = roleTextfield.text ?? ""
        
        guard !name.isEmpty && !size.isEmpty && !summary.isEmpty && !techStack.isEmpty && !role.isEmpty else {
            return
        }
        let project = Project(name: name,
                              size: Int(size) ?? 0,
                              summary: summary,
                              techStack: techStack,
                              role: role)
        callback?.didSaveProject(index: index, data: project)
        dismiss(animated: true, completion: nil)
    }
}
