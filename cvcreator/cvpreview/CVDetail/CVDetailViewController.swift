import UIKit

class CVDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var cvModel: CVModel?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CVDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = self.cvModel else {
            return 0
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let model = self.cvModel else {
            return 0
        }
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.cvModel else {
            return CVInformationCell()
        }
        return CVInformationCell()
    }
}
