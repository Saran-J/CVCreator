import UIKit

class CVEditInformationViewController: UIViewController {

    @IBOutlet weak var textfield: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    var type: InformationType = .address
    weak var detailCallback: CVDetailCallback?
    
    static func initFromStoryboard() -> CVEditInformationViewController? {
        return UIStoryboard.getViewController(name: "CVEditInformation") as? CVEditInformationViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = type.getTitle()
        textfield.layer.cornerRadius = 8.0
        textfield.layer.borderWidth = 2.0
        textfield.layer.borderColor = UIColor.systemGray6.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textfield.becomeFirstResponder()
    }
    
    func setupCallback(_ callBack: CVDetailCallback?) {
        self.detailCallback = callBack
    }
    
    func setupExisting(oldValue: String) {
        self.textfield.text = oldValue
    }
    
    @IBAction func onSave() {
        if let data = textfield.text {
            switch  type {
            case .address:
                detailCallback?.onUpdateAddress(address: data)
            case .careerObjective:
                detailCallback?.onUpdateObjective(objective: data)
            }
        }
        dismiss(animated: true, completion: nil)
    }
}
