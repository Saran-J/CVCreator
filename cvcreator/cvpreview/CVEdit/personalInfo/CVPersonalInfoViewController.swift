import UIKit
import IQKeyboardManagerSwift

class CVPersonalInfoViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker: UIImagePickerController?
    var detailCallback: CVDetailCallback?
    static func initFromStoryboard() -> CVPersonalInfoViewController? {
        return UIStoryboard.getViewController(name: "CVPersonalInfo") as? CVPersonalInfoViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.enable = true
        DispatchQueue.main.async { [weak self] in
            self?.imagePicker = UIImagePickerController()
            self?.imagePicker?.delegate = self
            self?.imagePicker?.mediaTypes = ["public.image"]
        }
        
    }
    
    func setExistingData(name: String?, email: String?, phone: String?, image: UIImage?) {
        nameTextField.text = name
        emailTextField.text = email
        phoneTextField.text = phone
        imageView.image = image
    }
    
    func setupCallback(_ callback: CVDetailCallback?) {
        detailCallback = callback
    }
    
    @IBAction func onSave() {
        detailCallback?.onUpdatePersonalInformation(
            name: nameTextField.text ?? "",
            email: emailTextField.text ?? "",
            phone: phoneTextField.text ?? "",
            image: imageView.image ?? UIImage())
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onChangeProfileImage() {
        let alert = AlertBuilder()
            .setTitle(title: "Please Select Image Source")
            .addPositiveButton(title: "Gallery", handler: { [weak self] _ in
                self?.presentGallary()
            })
            .addPositiveButton(title: "Camera", handler: { [weak self] _ in
                self?.presentCamera()
            })
            .addNegativeButton(title: "Cancel")
            .build()
        present(alert, animated: true)
    }
    
    func presentCamera() {
        imagePicker?.sourceType = .camera
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    func presentGallary() {
        imagePicker?.sourceType = .photoLibrary
        self.present(imagePicker!, animated: true, completion: nil)
    }
}

extension CVPersonalInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        self.imageView.image = image
        picker.dismiss(animated: true, completion: { [weak self] in })
    }
}
