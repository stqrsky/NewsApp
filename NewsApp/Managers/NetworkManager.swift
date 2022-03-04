//
//  NetworkManager.swift
//  NewsApp
//
//  Created by star on 20.02.22.
//

import UIKit

enum NewsError: String, Error {
    case universalError = "An unknown error has occurred"
    case unableToComplete = "Der Request konnte nicht abgeschlossen werden. Bitte überprüfe ggf. deine Internetverbindung"
    case invalidResponse = "Ungültige Serverantwort. Versuchen Sie es später erneut."
    case invalidData = "Ungültige Daten erhalten. Versuchen Sie es später erneut."
    case invalidURL = "Es wurde eine ungültige URL verwendet"
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {
        
    }
    
    private let baseURLString = "https://newsapi.org/v2/everything?q=apple&from=2022-03-03&to=2022-03-03&sortBy=popularity&apiKey="
    private let apiKey = "242a1569a8e04ef3b980f989de060ca1"
    
    func getNewsItems (completion: @escaping ((Result<NewsResponse, NewsError>) -> Void)) {
        let endpoint = baseURLString + apiKey
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                completion(.success(newsResponse))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String?, completed: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString ?? "") else {
            completed(#imageLiteral(resourceName: "placeholder"))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    
                completed(#imageLiteral(resourceName: "placeholder"))
                return
            }
            
            completed(image)
            
        }
        
        task.resume()
        
    }
}
