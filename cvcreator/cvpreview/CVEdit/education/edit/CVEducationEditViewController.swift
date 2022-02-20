import UIKit

class CVEducationEditViewController: UIViewController {
    
    weak var callback: CVEducationCallback?
    var index: Int = -1
    
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var passingYearTextField: UITextField!
    @IBOutlet weak var gpaTextField: UITextField!
    
    static func initFromStoryboard() -> CVEducationEditViewController? {
        return UIStoryboard.getViewController(name: "CVEducationEdit") as? CVEducationEditViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setCallback(_ callback: CVEducationCallback?) {
        self.callback = callback
    }
    
    func setExistingData(data: Education) {
        classTextField.text = data.eduClass
        passingYearTextField.text = data.passingYear
        gpaTextField.text = data.gpa
    }
    
    @IBAction func onSave() {
        let eduClass = classTextField.text ?? ""
        let passingYear = passingYearTextField.text ?? ""
        let gpa = gpaTextField.text ?? ""
        
        guard !eduClass.isEmpty && !passingYear.isEmpty && !gpa.isEmpty else {
            return
        }
        let education = Education(eduClass: eduClass, passingYear: passingYear, gpa: gpa)
        callback?.didSaveEducation(index: index, data: education)
        dismiss(animated: true, completion: nil)
    }
}
