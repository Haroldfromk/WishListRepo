

import UIKit

class DBTableViewController: UITableViewController {
    
    var savedList: [Lists] = [Lists]()
    let numberFormatter = NumberFormatter()
    let appDelegate =  (UIApplication.shared.delegate as! AppDelegate)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
        let price = Double(savedList[indexPath.row].price) * (100.00 - savedList[indexPath.row].discountPercentage) / 100
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "[\(savedList[indexPath.row].id)] \(savedList[indexPath.row].title ?? "None") - \(numberFormatter.string(from: price as NSNumber) ?? "0")$"
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteBtn = UIContextualAction(style: .normal, title: "Delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            let alert = UIAlertController(title: "삭제하기", message: "정말 삭제하시나요?.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .destructive, handler: { _ in
                
                self.context.delete(self.savedList[indexPath.row])
                self.savedList.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.endUpdates()
  
                self.appDelegate.saveContext()
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert,animated: false)
            
            success(true)
        }
        deleteBtn.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteBtn])
    }
    
}
