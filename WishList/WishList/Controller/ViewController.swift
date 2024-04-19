//
//  ViewController.swift
//  WishList
//
//  Created by Dongik Song on 4/9/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    lazy var savedList: [Lists] = [Lists]()
    var list: DataModel = DataModel(id: 0, title: "", description: "", price: 0, discountPercentage: 0.0, images: [""])
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var discountedLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let makingImageView = MakingImageView()
    let dataManager = DataManager()
    let alertManager = AlertManager()
    let coreManager = CoreManager()
    let numberFormatter = NumberFormatter()
    let request: NSFetchRequest<Lists> = Lists.fetchRequest()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        dataManager.delegate = self
        numberFormatter.numberStyle = .decimal
        dataManager.fetchRequest()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(reloadJson), for: .valueChanged)
        imageScrollView.delegate = self
        
    }
    
    // MARK: - Escaping Closure를 사용한 FetchRequest를 Pull to Refresh에 적용
    @objc func reloadJson() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            self.dataManager.fetchRequestWithClosure { result in
                switch result {
                case .success(let data):
                    self.list = data
                    DispatchQueue.main.async {
                        let price = self.numberFormatter.string(from: Double(self.list.price) * (100.00 - self.list.discountPercentage) / 100 as NSNumber)
                        self.titleLabel.text = self.list.title
                        self.bodyLabel.text = self.list.description
                        self.priceLabel.text = "\(self.numberFormatter.string(from: self.list.price as NSNumber) ?? "0") $"
                        self.discountedLabel.text = "할인 적용: \(price ?? "0")$"
                        self.setPageCount()
                        self.makingImageView.makingImage(list: self.list, scrollView: self.imageScrollView)
                        self.scrollViewDidScroll(self.imageScrollView)
                        
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        let alert = self.alertManager.makingAlert(title: "에러 발생", body: "데이터를 로드 하던 중 \(error)가 발생했습니다.")
                        self.present(alert, animated: true)
                    }
                }
            }
            self.scrollView.refreshControl?.endRefreshing()
        }
        
    }
    
    @IBAction func getDataBtn(_ sender: UIButton) {
        dataManager.fetchRequest()
    }
    
    @IBAction func saveListBtn(_ sender: UIButton) {
        
        // 중복값을 확인하기위해 Coredata에서 값을 가져옴.
        do {
            savedList = try context.fetch(request)
        } catch {
            let alert = alertManager.makingAlert(title: "에러 발생", body: "데이터를 로드 하던 중 오류가 발생했습니다.")
            self.present(alert, animated: true)
        }
        
        // Coredata의 값들 중 일치하는게 있을 경우. Alert표시.
        if savedList.filter({$0.id == list.id}).count == 1 {
            
            let alert = alertManager.makingAlert(title: "중복된 값이 존재합니다", body: "이미 해당 정보가 위시리스트에 저장되어있습니다.")
            self.present(alert, animated: true)
            
        } else {
            
            coreManager.saveData(model: list, paramContext: self.context)
            do {
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
            tableVC.savedList = savedList.sorted(by: {$0.id < $1.id})
            
            self.present(tableVC, animated: true)
            
        }
    }
 
}

// MARK: - ScrollView 기능 구현
extension ViewController: UIScrollViewDelegate {
    
    func setPageCount () { // page의 카운트를 정해줌.
        imagePageControl.numberOfPages = list.images.count - 1
    }
    
    private func setPageControlSelectedPage(currentPage:Int) { // 현재 페이지를 보여줌
        imagePageControl.currentPage = currentPage
    }
    
    func scrollViewDidScroll(_ imageScrollView: UIScrollView) {
        let value = imageScrollView.contentOffset.x/imageScrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    
}

// MARK: - Protocol 구현
extension ViewController: SendData {
    
    func sendList(data: DataModel?) {
        
        if let safeData = data {
            list = safeData
            DispatchQueue.main.async {
                let price = self.numberFormatter.string(from: Double(self.list.price) * (100.00 - self.list.discountPercentage) / 100 as NSNumber)
                self.titleLabel.text = self.list.title
                self.bodyLabel.text = self.list.description
                self.priceLabel.text = "\(self.numberFormatter.string(from: self.list.price as NSNumber) ?? "0") $"
                self.discountedLabel.text = "할인 적용: \(price ?? "0")$"
                self.setPageCount()
                self.makingImageView.makingImage(list: self.list, scrollView: self.imageScrollView)
                self.scrollViewDidScroll(self.imageScrollView)
                
            }
            
        } else {
            DispatchQueue.main.async {
                let alert = self.alertManager.makingAlert(title: "에러 발생", body: "데이터 로드중 문제가 발생했습니다.")
                self.present(alert, animated: true)
            }
        }
        
    }
    
}
