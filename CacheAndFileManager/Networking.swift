//
//  Networking.swift
//  CacheAndFileManager
//
//  Created by Volodymyr D on 27.08.2022.
//

import UIKit

class Networking {
    
    private let cache = NSCache<NSString, UIImage>()
    static let shared = Networking()
    private init() {}
    
    public func getImage(from strAdress: String, comp: @escaping (UIImage?) -> Void) {
        if let cacheImage = cache.object(forKey: strAdress as NSString) {
            comp(cacheImage)
            print("from cache")
            return
        }
        guard let url = URL(string: strAdress) else {
            print("something with url")
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, err in
            if let err = err {
                print(err.localizedDescription)
            }
            guard let data = data else {
                print("something with data")
                return
            }
            let image = UIImage(data: data)
            comp(image)
            print("from web")
            if let image = image {
                self?.cache.setObject(image, forKey: strAdress as NSString)
            }
        }.resume()
        
    }
    
}
