//
//  NewsViewModel.swift
//  BuzzByte
//
//  Created by Adarsh Singh on 13/11/23.
//

import Foundation
import UIKit

final class NewsViewModel{
    
    var news: NewsModel?
    var eventHandler:((_ event: Event)->Void)?
    func fetchdata(){
        self.eventHandler?(.loading)
        let searchQuery = ApiManager.shared.searchString
        ApiManager.shared.request(modelType: NewsModel.self, type: DataEndPoint.news(searchString: searchQuery)) { response in
            self.eventHandler?(.stopLoading)
            switch response{
                
            case .success(let news):
                self.news = news
                self.eventHandler?(.dataLoaded)
                
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
}

extension NewsViewModel{
    enum Event{
        
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        
    }
    
}
