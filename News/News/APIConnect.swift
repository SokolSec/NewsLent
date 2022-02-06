//
//  APIConnect.swift
//  News
//
//  Created by Даниил Сокол on 05.02.2022.
//

import Foundation

class APIConnect {
    static let linkAPI = APIConnect()
    struct Constants {
        static let headLineTopURL = URL(string: "https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=ddd336376b654441925c4acc8524dcbb
    ]\")
    }
    
    private init() {}
    
    public func newsBestStory(completion: @escaping (Result<[Article], Error>)->Void){
        guard let url = Constants.headLineTopURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
        if let error = error {
            completion(.failure(error))
        }
        else if let data = data {
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                print("Articles: \(result.articles.count)")
                completion(.success(result.articles))
            }
            catch {
                completion(.failure(error))
            }
        }
        }
        task.resume()
    }
}

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article : Codable{
    let source : Source
    let title : String
    let description : String
    let url : String
}

struct Source : Codable {
    let name : String
}

