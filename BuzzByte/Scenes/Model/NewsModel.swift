//
//  NewsModel.swift
//  BuzzByte
//
//  Created by Adarsh Singh on 13/11/23.
//

import Foundation

struct NewsModel: Codable{
    var articles:[newsArticles]?
}

struct newsArticles: Codable{
    
    let author:String?
    let title: String
    let description: String?
    
    let url: URL?
    let urlToImage: URL?
}
