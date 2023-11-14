//
//  Extension + UIimage.swift
//  BuzzByte
//
//  Created by Adarsh Singh on 13/11/23.
//

import Foundation

import Kingfisher
import UIKit

extension UIImageView{
    
    func setImage(with urlString: String){
        
        guard let url = URL.init(string: urlString) else{
            return
        }
        
        let resource = KF.ImageResource(downloadURL: url,cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
