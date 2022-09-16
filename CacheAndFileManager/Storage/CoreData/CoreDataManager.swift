//
//  CoreDataManager.swift
//  CacheAndFileManager
//
//  Created by Volodymyr D on 28.08.2022.
//

import CoreData
import UIKit


class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init(){}
 
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreSaving")
        container.loadPersistentStores(completionHandler: { (_, _) in })
        return container
    }()
    
    public func save(image: UIImage?) {
        guard let image = image else { return }
        let newImage = ImageModel(context: persistentContainer.viewContext)
        let data = image.jpegData(compressionQuality: 1)
        newImage.image = data
        try! persistentContainer.viewContext.save()
    }
    
    public func fethData() -> [UIImage?] {
        var images = [UIImage?]()
        do{
            (try persistentContainer.viewContext.fetch(ImageModel.fetchRequest()).map { $0.image }).forEach { 
                if let data = $0 {
                    images.append(UIImage(data: data))
                }
            }
        }catch{
            print(error.localizedDescription)
        }
        return images
    }
    
}
