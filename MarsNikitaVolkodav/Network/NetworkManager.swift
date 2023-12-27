import Foundation
protocol NetworkManagerProtocol {
    func searchImagesCamera(camera: String, completion: @escaping (NASAModel?, NetworkError?) -> Void)
    func searchImagesEarthDate(earthDate: String, completion: @escaping (NASAModel?, NetworkError?) -> Void)
    func searchImages(withCamera: String, andEarthDate: String, completion: @escaping (NASAModel?, NetworkError?) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    private let apiKey = "ppCDujWfsYGQtRCX4Jsgbn4R6064EbgMAGiMNhg0"
    
    private var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = "/mars-photos/api/v1/rovers/curiosity/photos"
        return components
    }()
    
    func searchImages(withCamera: String, andEarthDate: String, completion: @escaping (NASAModel?, NetworkError?) -> Void) {
        urlComponents.queryItems = [
            URLQueryItem(name: "earth_date", value: andEarthDate),
            URLQueryItem(name: "camera", value: withCamera),
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        guard let url = urlComponents.url else {
            completion(nil, NetworkError.badURL)
            return
        }
        performDataTask(with: url, completion: completion)
    }
    
    func searchImagesEarthDate(earthDate: String, completion: @escaping (NASAModel?, NetworkError?) -> Void) {
        urlComponents.queryItems = [
            URLQueryItem(name: "sol", value: "1000"),
            URLQueryItem(name: "earth_date", value: earthDate),
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        guard let url = urlComponents.url else {
            completion(nil, NetworkError.badURL)
            return
        }
        performDataTask(with: url, completion: completion)
    }
    
    func searchImagesCamera(camera: String, completion: @escaping (NASAModel?, NetworkError?) -> Void) {
        urlComponents.queryItems = [
            URLQueryItem(name: "sol", value: "1000"),
            URLQueryItem(name: "camera", value: camera),
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        guard let url = urlComponents.url else {
            completion(nil, NetworkError.badURL)
            return
        }
        performDataTask(with: url, completion: completion)
    }
    
    private func performDataTask(with url: URL, completion: @escaping (NASAModel?, NetworkError?) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            guard let data = data else {
                completion(nil, NetworkError.noDataError)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, NetworkError.badServerResponse)
                return
            }
            
            guard error == nil else {
                completion(nil, NetworkError.unknownError)
                return
            }
            
             self.handleResponse(data: data, httpResponse: httpResponse, completion: completion)
        }
        .resume()
    }
    
    private func handleResponse(data: Data, httpResponse: HTTPURLResponse, completion: @escaping (NASAModel?, NetworkError?) -> Void) {
        switch httpResponse.statusCode {
        case 200:
            do {
                let parsingData = try JSONDecoder().decode(NASAModel.self, from: data)
                completion(parsingData, nil)
            } catch {
                completion(nil, NetworkError.badServerResponse)
            }
        case 400:
            completion(nil, NetworkError.badRequest)
        case 401:
            completion(nil, NetworkError.unauthorized)
        case 403:
            completion(nil, NetworkError.forbidden)
        case 404:
            completion(nil, NetworkError.notFound)
        case 500:
            completion(nil, NetworkError.internalServerError)
        default:
            completion(nil, NetworkError.unknownError)
        }
    }
}
