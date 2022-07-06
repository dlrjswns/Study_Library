//
//  CacheManager.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/07/06.
//

import UIKit

class CacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}

extension UIImageView {
    func setImage(string: String) {
        let key = NSString(string: string)
        if let image = CacheManager.shared.object(forKey: key) {
            DispatchQueue.main.async {
                self.image = image
            }
            return
        }
        
        if let url = URL(string: string) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let _ = error {
                    DispatchQueue.main.async {
                        self.image = UIImage(systemName: "heart.fill")
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    if let data = data,
                       let fetchImage = UIImage(data: data) {
                        CacheManager.shared.setObject(fetchImage, forKey: key)
                        self.image = fetchImage
                    }
                }
                
            }.resume()
        }
    }
}
