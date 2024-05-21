import Foundation

class NetworkManager {
    let imageCache = NSCache<NSString, NSData>()
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseUrlString = "https://alfredzero.github.io/Data/data.json"
    
    func getEventos(completion: @escaping ([Eventos]?) -> Void) {
        guard let url = URL(string: baseUrlString) else {
            print("Invalid URL")
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            do {
                let eventosEnvelope = try JSONDecoder().decode(EventosEnvelope.self, from: data)
                let eventosContainer = eventosEnvelope.eventos
                let eventos = eventosContainer.eventos
                DispatchQueue.main.async {
                    completion(eventos)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let data = data else {
                    completion(nil)
                    return
                }
                
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }.resume()
        }
    }
}
