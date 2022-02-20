import UIKit

protocol CVWorkExpCallback: AnyObject {
    func didSaveWorkExp(index: Int, data: WorkExperience)
}

class CVWorkExpViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var workExpData: [WorkExperience] = []
    var router = CVWorkExpRouter()
    let newIndex = -1
    weak var detailCallback: CVDetailCallback?
    static func initFromStoryboard() -> CVWorkExpViewController? {
        return UIStoryboard.getViewController(name: "CVWorkExp") as? CVWorkExpViewController
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
        tableView.register(UINib(nibName: "CVWorkExperienceCell", bundle: nil),
                           forCellReuseIdentifier: CVWorkExperienceCell.identifier)
    }
    
    @IBAction func onSave() {
        detailCallback?.onUpdateWorkExpData(workExp: workExpData)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAdd() {
        router.presentEditWorkExp(index: newIndex)
    }
}

extension CVWorkExpViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workExpData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CVWorkExperienceCell.identifier) as? CVWorkExperienceCell ?? CVWorkExperienceCell()
        cell.setData(data: workExpData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.presentEditWorkExp(index: indexPath.row, data: workExpData[indexPath.row])
    }
}

extension CVWorkExpViewController: CVWorkExpCallback {
    func didSaveWorkExp(index: Int, data: WorkExperience) {
        if index == newIndex {
            workExpData.append(data)
        } else {
            workExpData[index] = data
        }
        tableView.reloadData()
    }
}
