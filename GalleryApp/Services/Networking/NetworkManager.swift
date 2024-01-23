//
//  Networking.swift
//  GalleryApp
//
//  Created by Siarhei Anoshka on 23.01.24.
//

import UIKit

private enum NetworkSettings {
    enum HTTPMethods: String {
        case get = "GET"
    }
    
    enum APIKey: String {
        case authorization = "Authorization"
        case accessKey = "Client-ID tchuIJCmQVwmlJuc92jLQOqGJkwgn_7wrrZYN52SySs"
    }
    
    enum APIRequest: String {
        case scheme = "https"
        case host = "api.unsplash.com"
        case path = "/photos"
        case page = "page"
        case perPage = "per_page"
    }
}

final class NetworkManager {
    
    static let shared = NetworkManager()

    private let photosPerPage = 30
    private var page: Int = 1
    
    private init() {}
    
    func fetchImages(completion: @escaping ([UnsplashPhoto]?) -> Void) {
        makeRequest { data, error in
            guard error == nil else {
                print("error here")
                completion(nil)
                return
            }
            let results = self.decodeJSON(type: [UnsplashPhoto].self, from: data)
            completion(results)
            self.page += 1
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let parsedJSON = try decoder.decode(type.self, from: data)
            return parsedJSON
        } catch {
            return nil
        }
    }
    
    private func makeRequest(completion: @escaping (Data?, Error?) -> Void) {
        guard let url = createURL() else { return }
        var request = URLRequest(url: url)
        request.httpMethod = NetworkSettings.HTTPMethods.get.rawValue
        request.setValue(NetworkSettings.APIKey.accessKey.rawValue,
                         forHTTPHeaderField: NetworkSettings.APIKey.authorization.rawValue)
        let task = createDataTask(with: request, completion: completion)
        task.resume()
    }
    
    private func createURL() -> URL? {
        var components = URLComponents()
        components.scheme = NetworkSettings.APIRequest.scheme.rawValue
        components.host = NetworkSettings.APIRequest.host.rawValue
        components.path = NetworkSettings.APIRequest.path.rawValue
        components.queryItems = [
            URLQueryItem(name: NetworkSettings.APIRequest.page.rawValue, value: String(page)),
            URLQueryItem(name: NetworkSettings.APIRequest.perPage.rawValue, value: String(photosPerPage))
        ]
        return components.url
    }
    
    private func createDataTask(with request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
