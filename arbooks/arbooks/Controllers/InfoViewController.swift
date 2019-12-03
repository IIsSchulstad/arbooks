import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var infoTableView: UITableView!
    var info: Info?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = info?.title
        infoTextView.text = info?.textArray[0]
        
        loadTableView()
    }
    
    func loadTableView() {
        //Not yet implemented
    }
}
