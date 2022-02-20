import UIKit

protocol CVProjectCallback: AnyObject {
    func didSaveProject(index: Int, data: Project)
}

class CVProjectViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var projectData: [Project] = []
    var router = CVProjectRouter()
    let newIndex = -1
    weak var detailCallback: CVDetailCallback?
    static func initFromStoryboard() -> CVProjectViewController? {
        return UIStoryboard.getViewController(name: "CVProject") as? CVProjectViewController
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
        tableView.register(UINib(nibName: "CVProjectCell", bundle: nil),
                           forCellReuseIdentifier: CVProjectCell.identifier)
        tableView.register(UINib(nibName: "CVAddCell", bundle: nil),
                           forCellReuseIdentifier: CVAddCell.identifier)
    }
    
    @IBAction func onSave() {
        detailCallback?.onUpdateProjectData(project: projectData)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onAdd() {
        router.presentEditProject(index: newIndex)
    }
}

extension CVProjectViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CVProjectCell.identifier) as? CVProjectCell ?? CVProjectCell()
        cell.setData(data: projectData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.presentEditProject(index: indexPath.row, data: projectData[indexPath.row])
    }
}

extension CVProjectViewController: CVProjectCallback {
    func didSaveProject(index: Int, data: Project) {
        if index == newIndex {
            projectData.append(data)
        } else {
            projectData[index] = data
        }
        tableView.reloadData()
    }
}
