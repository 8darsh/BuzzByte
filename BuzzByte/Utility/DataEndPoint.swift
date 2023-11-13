//
//  DataEndPoint.swift
//  BuzzByte
//
//  Created by Adarsh Singh on 13/11/23.
//

import Foundation

enum DataEndPoint{
    
    case news(searchString: String)
}

extension DataEndPoint: EndPointType{
    var path: String {
        switch self {
        case .news(let searchString):
            if(searchString == ""){
                return "country=in&apiKey=43e04cc8499943fa993a7b540e7382b7"
            }else{
                return ""
            }
        }
    }
    
    var baseUrl: String {
        switch self {
        case .news:
            return "https://newsapi.org/v2/top-headlines?"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .news:
            return .get
        }
    }
    
    var body: Encodable? {
        switch self {
        case .news:
            return nil
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
