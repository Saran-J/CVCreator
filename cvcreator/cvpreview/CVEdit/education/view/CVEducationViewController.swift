import UIKit

protocol CVEducationCallback: AnyObject {
    func didSaveEducation(index: Int, data: Education)
}

class CVEducationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var eduData: [Education] = []
    var router = CVEducationRouter()
    let newIndex = -1
    weak var detailCallback: CVDetailCallback?
    static func initFromStoryboard() -> CVEducationViewController? {
        return UIStoryboard.getViewController(name: "CVEducation") as? CVEducationViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setupCallback(_ callBack: CVDetailCallback?) {
        self.detailCallback = callBack
    }
    
    func setup() {
        router.viewController = self
        tableView.register(UINib(nibName: "CVEducationCell", bundle: nil),
                           forCellReuseIdentifier: CVEducationCell.identifier)
    }
    
    @IBAction func onSave() {
        detailCallback?.onUpdateEducationData(education: eduData)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAdd() {
        router.presentEditEducation(index: newIndex)
    }
}

extension CVEducationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eduData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CVEducationCell.identifier) as? CVEducationCell ?? CVEducationCell()
        cell.setData(data: eduData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.presentEditEducation(index: indexPath.row, data: eduData[indexPath.row])
    }
}

extension CVEducationViewController: CVEducationCallback {
    func didSaveEducation(index: Int, data: Education) {
        if index == newIndex {
            eduData.append(data)
        } else {
            eduData[index] = data
        }
        tableView.reloadData()
    }
}
