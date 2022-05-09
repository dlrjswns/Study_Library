//
//  CacheManager.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/04.
//

import UIKit

class CacheManager {
    static let shared = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func setImage(with imageString: String?) {
        
        guard let imageString = imageString,
              let url = URL(string: imageString) else {
            return
        }
        
        let key = imageString as NSString
        
        if let image = CacheManager.shared.object(forKey: key) {
            DispatchQueue.main.async {
                self.image = image
            }
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("dfdfdfdfd")
                    return
                }
                
                if let data = data,
                   let image = UIImage(data: data){
            
                    DispatchQueue.main.async {
                        self.image = image
                    }
                
                    CacheManager.shared.setObject(image, forKey: key)
                    return
                    }
            }
        task.resume()
    }
}
