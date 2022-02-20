import UIKit
import RxSwift
import PDFGenerator
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
    
    @IBAction func onExport() {
//        generatePDF()
    }
    
    func generatePDF() {
        let v1 = self.tableView ?? UITableView()
        let dst = URL(fileURLWithPath: NSTemporaryDirectory().appending("sample1.pdf"))
        // outputs as Data
        do {
            let data = try PDFGenerator.generated(by: [v1])
            try data.write(to: dst, options: .atomic)
        } catch (let error) {
            print(error)
        }

        // writes to Disk directly.
        do {
            try PDFGenerator.generate([v1], to: dst)
        } catch (let error) {
            print(error)
        }
        
        router.presentPDF()
    }
}


