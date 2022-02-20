import UIKit
import RxSwift
class CVDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var cvModel: CVModel?
    var router = CVDetailRouter()
    let viewModel = CVDetailViewModel()
    let disposeBag = DisposeBag()
    var callback: CVListCallback?
    static func initFromStoryboard() -> CVDetailViewController? {
        let storyboard = UIStoryboard(name: "CVDetail", bundle: .main)
        return storyboard.instantiateInitialViewController() as? CVDetailViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        tableView.reloadData()
    }
    
    func setCallback(callback: CVListCallback?) {
        self.callback = callback
    }
    
    func setup() {
        router.viewController = self
        tableView.register(UINib(nibName: "CVImageCell", bundle: nil),
                           forCellReuseIdentifier: CVImageCell.identifier)
        tableView.register(UINib(nibName: "CVInformationCell", bundle: nil),
                           forCellReuseIdentifier: CVInformationCell.identifier)
        tableView.register(UINib(nibName: "CVWorkExperienceCell", bundle: nil),
                           forCellReuseIdentifier: CVWorkExperienceCell.identifier)
        tableView.register(UINib(nibName: "CVEducationCell", bundle: nil),
                           forCellReuseIdentifier: CVEducationCell.identifier)
        tableView.register(UINib(nibName: "CVProjectCell", bundle: nil),
                           forCellReuseIdentifier: CVProjectCell.identifier)
        tableView.register(UINib(nibName: "HeaderView", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        
        if cvModel == nil {
            cvModel = CVModel()
        }
    }
    
    func bind() {
        disposeBag.insert(
            [
                viewModel.onSave.bind { [weak self] _ in
                    self?.callback?.didSaveNewCV()
                    self?.navigationController?.popViewController(animated: true)
                }
            ])
    }

    @IBAction func onSave() {
        guard let model = cvModel else { return }
        viewModel.saveCV(model: model)
    }
}


