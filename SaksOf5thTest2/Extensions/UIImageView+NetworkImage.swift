//
//  UIImageView+NetworkImage.swift
//  SaksOf5thTest2
//
//  Created by Anthony Ebuka Nwudo on 20/08/2022.
//
import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    func setImage(with urlString: String, placeholder: Bool = false){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        
        if placeholder{
            self.kf.setImage(with: resource, placeholder:  #imageLiteral(resourceName: "icons8-full_image"))
        }else{
            self.kf.setImage(with: resource)
            kf.indicatorType = .activity
        }
        
    }
}
