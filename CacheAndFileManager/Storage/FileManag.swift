//
//  FileManag.swift
//  CacheAndFileManager
//
//  Created by Volodymyr D on 28.08.2022.
//

import Foundation
import UIKit

enum Folder {
    case imageFolder
    public var urlAdress: URL? {
        switch self {
        case .imageFolder:
            return folderWithImages
        }
    }
    private var folderWithImages: URL? {
        let url = FileManager.default.urls(for: .documentDirectory,
                                   in: .userDomainMask).first
        return url?.appendingPathComponent("savedImages")
    }
}

class FileManag {
     
    static let shared = FileManag()
    private let fileManager = FileManager.default
     
    private init (){}
      
    public func getAllImages(from folder: Folder) -> [UIImage] {
        guard let folderWithImages = folder.urlAdress else { return []}
        switch folder {
        case .imageFolder:
            var images = [UIImage]()
            do {
                try fileManager.contentsOfDirectory(atPath: folderWithImages.path).forEach {
                    print($0)
                    if let data = fileManager.contents(atPath: folderWithImages.appendingPathComponent($0).path),
                       let image = UIImage(data: data) {
                        images.append(image)
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
            return images
        }
    }
    
    
    public func save(image: UIImage?, toFolder folder: Folder, withName name: String?) {
        guard
            let image = image,
            let data = image.jpegData(compressionQuality: 1),
            let imageFolder = folder.urlAdress
        else { return }
        print(imageFolder.path)
        let urlForFile = imageFolder.appendingPathComponent("\(name ?? "unkown")-\(data.description).jpg")
        do{
            if !fileManager.fileExists(atPath: urlForFile.path) {
                try fileManager.createDirectory(at: imageFolder,
                                                withIntermediateDirectories: true)
                try data.write(to: urlForFile)
            }else{
                print("alreadyExist")
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
}
