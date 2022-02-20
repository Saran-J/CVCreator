import UIKit
import RxSwift
import RxCocoa

protocol CVListCallback: AnyObject {
    func didSaveNewCV()
}

class CVListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createNewButton: UIButton!
    @IBOutlet weak var addButton: UIBarButtonItem!
    let cellId = "CVCell"
    let viewModel = CVListViewModel()
    let disposeBag = DisposeBag()
    var router = CVListRouter()
    override func viewDidLoad() {
        super.viewDidLoad()
        router.viewController = self
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getCVList()
    }
    
    func bind() {
        disposeBag.insert([
            viewModel.output
            .onGetCVList.asObservable()
            .bind(
                to: tableView.rx.items(cellIdentifier: cellId,
                                       cellType: CVListCell.self)
            ) { (row, model, cell) in
                cell.name.text = model.name
            },
            tableView.rx.itemSelected.bind(onNext: { [weak self] indexPath in
                let model = self?.viewModel.getExistingCV(index: indexPath.row)
                self?.router.routeToEditCV(model: model)
            }),
            viewModel.output.onError.drive { [weak self] error in
                self?.handleError(error)
            },
            createNewButton.rx.tap.bind { [weak self] _ in
                self?.router.routeToEditCV()
            },
            addButton.rx.tap.bind(onNext: { [weak self] _ in
                self?.router.routeToEditCV()
            })
        ])
    }
    
    func handleError(_ error: CVListError) {
        switch error {
        case .empty:
            tableView.isHidden = true
        }
    }
}

extension CVListViewController: CVListCallback {
    func didSaveNewCV() {
        viewModel.getCVList()
    }
}
