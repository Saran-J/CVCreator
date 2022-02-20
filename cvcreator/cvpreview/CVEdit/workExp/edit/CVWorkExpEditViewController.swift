import UIKit

class CVWorkExpEditViewController: UIViewController {
    weak var callback: CVWorkExpCallback?
    var index: Int = -1
    
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    static func initFromStoryboard() -> CVWorkExpEditViewController? {
        return UIStoryboard.getViewController(name: "CVWorkExpEdit") as? CVWorkExpEditViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setCallback(_ callback: CVWorkExpCallback?) {
        self.callback = callback
    }
    
    func setExistingData(data: WorkExperience) {
        companyTextField.text = data.companyName
        yearTextField.text = String(data.duration.year)
        monthTextField.text = String(data.duration.month)
    }
    
    @IBAction func onSave() {
        let company = companyTextField.text ?? ""
        let year = yearTextField.text ?? ""
        let month = monthTextField.text ?? ""
        
        guard !company.isEmpty && (!year.isEmpty || !month.isEmpty) else {
            return
        }
        let workExp = WorkExperience(
            companyName: company,
            duration: WorkDuration(
                year: Int(year) ?? 0,
                month: Int(month) ?? 0
            )
        )
        callback?.didSaveWorkExp(index: index, data: workExp)
        dismiss(animated: true, completion: nil)
    }
}
