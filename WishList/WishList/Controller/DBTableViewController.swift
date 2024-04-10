

import UIKit

class DBTableViewController: UITableViewController {
    
    var savedList: [Lists] = [Lists]()
    let numberFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFormatter.numberStyle = .decimal
        tableView.reloadData()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return savedList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constansts.cellIdentifier) else {
            return UITableViewCell()
        }
        
        let price = Double(savedList[indexPath.row].price) * (100.00 - savedList[indexPath.row].discountPercentage)
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.text = "[\(savedList[indexPath.row].id)] \(savedList[indexPath.row].title ?? "None") - \(numberFormatter.string(from: price as NSNumber) ?? "0")$"

        cell.selectionStyle = .none
        
        return cell
    }


}
