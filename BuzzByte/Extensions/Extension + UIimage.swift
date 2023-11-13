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
    
    func setImage(with url: URL){
        
        let resource = KF.ImageResource(downloadURL: url)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
