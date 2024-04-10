
import Foundation

protocol SendData: AnyObject {
    func sendList (data: [DataModel])
}

class DataManager {

    weak var delegate: SendData?
    
    func fetchRequest() {
        
        let pageNumber = (1...100).randomElement() ?? 1

        let url = "https://dummyjson.com/products/\(pageNumber)"
        
        if let url = URL(string: url) {
 
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: url) { (data,response,error) in
                
                if error != nil {
                    self.delegate?.sendList(data: [])
                    return
                }
                
                if let safeData = data {
                    let decodedData = self.decodingJson(data: safeData)
                    self.delegate?.sendList(data: decodedData)
                }
            }
            
            task.resume()
        }

    }
    
    func decodingJson (data: Data) -> [DataModel] {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(DataModel.self, from: data)
            let id = decodedData.id
            let title = decodedData.title
            let description = decodedData.description
            let price = decodedData.price
            let discountPercentage = decodedData.discountPercentage
            let thumnail = decodedData.thumbnail
            
            let list: [DataModel] = [DataModel(id: id, title: title, description: description, price: price, discountPercentage: discountPercentage, thumbnail: thumnail)]
          
            return list
            
        } catch {
            print(error)
            return []
        }
            
    }
    
}
