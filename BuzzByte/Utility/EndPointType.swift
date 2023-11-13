//
//  EndPointType.swift
//  BuzzByte
//
//  Created by Adarsh Singh on 13/11/23.
//

import Foundation

enum HTTPMethods: String{
    case get = "GET"
}

protocol EndPointType{
    
    var path: String {get}
    var baseUrl: String {get}
    var url: URL? {get}
    
    var method: HTTPMethods {get}
    var body: Encodable? {get}
    var headers: [String:String]? {get}
}
