//
//  ViewController.swift
//  WishList
//
//  Created by Dongik Song on 4/9/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var list: [DataModel] = [DataModel]()
    var savedList: [Lists] = [Lists]()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dataManager = DataManager()
    let alertManager = AlertManager()
    let numberFormatter = NumberFormatter()
    let request: NSFetchRequest<Lists> = Lists.fetchRequest()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        dataManager.delegate = self
        numberFormatter.numberStyle = .decimal
        dataManager.fetchRequest()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(reloadJson), for: .valueChanged)
    }
    
    @objc func reloadJson() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.dataManager.fetchRequest()
            self.scrollView.refreshControl?.endRefreshing()
        }
        
    }
    
    @IBAction func getDataBtn(_ sender: UIButton) {
        dataManager.fetchRequest()
    }
    
    
    @IBAction func saveListBtn(_ sender: UIButton) {

        do {
            
            savedList = try context.fetch(request)
            
        } catch {
            let alert = alertManager.makingAlert(title: "에러 발생", body: "데이터를 로드 하던 중 오류가 발생했습니다.")
            self.present(alert, animated: true)
        }
        
        if savedList.filter({$0.id == list[0].id}).count == 1 {
            
            let alert = alertManager.makingAlert(title: "중복된 값이 존재합니다", body: "이미 해당 정보가 위시리스트에 저장되어있습니다.")
            self.present(alert, animated: true)
            
        } else {
            
            let newItem = Lists(context: self.context)
            newItem.id = Int64(list[0].id)
            newItem.title = list[0].title
            newItem.price = Int64(list[0].price)
            newItem.discountPercentage = list[0].discountPercentage
            
            do
            {
                try context.save()
                
            } catch {
                let alert = alertManager.makingAlert(title: "에러발생", body: "\(error.localizedDescription)가 발생했습니다.")
                self.present(alert, animated: true)
                
            }
            
        }
        
        savedList.removeAll()
        dataManager.fetchRequest()
    
    }
    
    
    
    @IBAction func showDBBtn(_ sender: UIButton) {
        
        do {
            savedList = try context.fetch(request)
        } catch {
            let alert = alertManager.makingAlert(title: "에러발생", body: "\(error.localizedDescription)가 발생했습니다.")
            self.present(alert, animated: true)
            
        }
        
        
        if let tableVC = self.storyboard?.instantiateViewController(identifier: Constansts.tableVC) as? DBTableViewController {
            
            tableVC.savedList = savedList
            
            self.present(tableVC, animated: true)
            
        }
    }
}

extension ViewController: SendData {
    
    func sendList(data: [DataModel]) {
        
        if !data.isEmpty {
            list = data
            
            DispatchQueue.main.async {
                let price = self.numberFormatter.string(from: Double(self.list[0].price) * (100.00 - self.list[0].discountPercentage) / 100 as NSNumber)
                self.imageView.load(url: URL(string: self.list[0].thumbnail)!)
                self.titleLabel.text = self.list[0].title
                self.bodyLabel.text = self.list[0].description
                self.priceLabel.text = "\(price ?? "0")$"
                
            }
        } else {
            
            DispatchQueue.main.async {
                let alert = self.alertManager.makingAlert(title: "에러 발생", body: "데이터 로드중 문제가 발생했습니다.")
                self.present(alert, animated: true)
            }

        }

    }
   
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
