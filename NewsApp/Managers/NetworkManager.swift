//
//  NetworkManager.swift
//  NewsApp
//
//  Created by star on 20.02.22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {
        
    }
    
    private let baseURLString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey="
    private let apiKey = "242a1569a8e04ef3b980f989de060ca1"
    
    func getNewsItems (completion: @escaping (NewsResponse) -> Void) {
        let endpoint = baseURLString + apiKey
        
        guard let url = URL(string: endpoint) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                completion(newsResponse)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
