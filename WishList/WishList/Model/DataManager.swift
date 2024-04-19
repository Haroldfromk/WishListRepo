
import Foundation

protocol SendData: AnyObject {
    func sendList (data: DataModel?)
}

class DataManager {

    weak var delegate: SendData?
    
    // MARK: - Protocol을 사용한 Data전달.
    func fetchRequest() {
        
        let pageNumber = (1...100).randomElement() ?? 1
        let url = "https://dummyjson.com/products/\(pageNumber)"
        
        if let url = URL(string: url) {
            
            let urlSession = URLSession(configuration: .default)
 
            let task = urlSession.dataTask(with: url) { (data,response,error) in
                
                if error != nil {
                    self.delegate?.sendList(data: nil)
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
    
    // MARK: - @Escaping Closure를 사용한 Data전달.
    func fetchRequestWithClosure(completion: @escaping(Result<DataModel, Error>) -> Void) {
        
        let pageNumber = (1...100).randomElement() ?? 1
        
        if let url = URL(string: "https://dummyjson.com/products/\(pageNumber)") {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response ,error) in
                
                if let error {
                    completion(.failure(error))
                    return
                }
                
                
                if let safeData = data {
    
                    if let decodedData = self.decodingJson(data: safeData) {
                        completion(.success(decodedData))
                        return
                    }
                }
            }
            task.resume()
        } else {
            
        }
        
    }
    
    
    // MARK: - JsonDecoding
    func decodingJson (data: Data) -> DataModel? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(DataModel.self, from: data)
            let id = decodedData.id
            let title = decodedData.title
            let description = decodedData.description
            let price = decodedData.price
            let discountPercentage = decodedData.discountPercentage
            let images = decodedData.images
            
            let list: DataModel = DataModel(id: id, title: title, description: description, price: price, discountPercentage: discountPercentage, images: images)
          
            return list
            
        } catch {
            print(error)
            return nil
        }
            
    }
    
}
