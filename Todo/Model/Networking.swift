import Foundation

enum networkingError: Error {
    case dataError
    case networkError
    case parseError
}


class Networking {
    
    static let shared = Networking()
    
    private init() {}
    
    typealias NetworkCompletion = (Result<Data, networkingError>) -> Void
    
    func fetchMusic(imageUrl: String, completionHandler: @escaping NetworkCompletion) {
        let url = "\(imageUrl)"
        performRequest(with: url) { result in
            completionHandler(result)
        }
    }
    
    func performRequest(with urlString: String, completionHandler: @escaping NetworkCompletion) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                completionHandler(.failure(.networkError))
                return
            }
            
            guard let safeData = data else {
                completionHandler(.failure(.dataError))
                return
            }
            
            
            completionHandler(.success(safeData))
            
        }.resume()
    }
}
