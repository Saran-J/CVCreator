import UIKit

class CVSkillViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextField!
    
    weak var detailCallback: CVDetailCallback?
    
    static func initFromStoryboard() -> CVSkillViewController? {
        return UIStoryboard.getViewController(name: "CVSkill") as? CVSkillViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupCallback(_ callBack: CVDetailCallback?) {
        self.detailCallback = callBack
    }
    
    func setupExisting(oldValue: String) {
        self.textView.text = oldValue
    }
    
    @IBAction func onSave() {
        if let skills = textView.text, !skills.isEmpty {
            self.detailCallback?.onUpdateSkill(skills: skills)
        }
        dismiss(animated: true, completion: nil)
    }
}
