//
//  ApiManager.swift
//  BuzzByte
//
//  Created by Adarsh Singh on 13/11/23.
//

import Foundation

enum DataError:Error{
    
    case invalidResponse
    case invalidUrl
    case invalidData
    case network(Error?)
}
typealias Handler<T> = (Result<T, DataError>)->Void

class ApiManager: Codable{
    public var searchString:String = ""
    static let shared = ApiManager()
    init(){}
    
    func updateSearchQuery(query: String, completion: @escaping Handler<NewsModel>){
        searchString = query
        let searchEndPoint = DataEndPoint.news(searchString: query)
        request(modelType: NewsModel.self, type:searchEndPoint, completion: completion)
    }
    
    func request<T: Codable>(
        modelType:T.Type,
        type: EndPointType,
        completion: @escaping Handler<T>
    ){
        
        guard let url = type.url else{
            completion(.failure(.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        
        if let parameter = type.body{
            request.httpBody = try? JSONEncoder().encode(parameter)
        }
        
        request.allHTTPHeaderFields = type.headers
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data,error == nil else{
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return
            }
            
            do{
                
                let news = try JSONDecoder().decode(modelType, from: data)
                completion(.success(news))
                
            }catch{
                completion(.failure(.network(error)))
            }
        }.resume()
        
    }
}
