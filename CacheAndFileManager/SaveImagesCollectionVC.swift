//
//  SaveImagesCollectionViewController.swift
//  CacheAndFileManager
//
//  Created by Volodymyr D on 28.08.2022.
//

import UIKit

enum ImageVCType {
    case fileManager
    case coreData
}

class SaveImagesCollectionVC: UICollectionViewController {
    
    var vcType: ImageVCType?
    var savedImages = [UIImage]()
    
    //MARK: - Life Cycle
    convenience init(vcType: ImageVCType, collViewLayout: UICollectionViewLayout) {
        self.init(collectionViewLayout: collViewLayout)
        self.vcType = vcType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        confCollectionView()
    }
    
    //MARK: - Metods
    private func fetchData() {
        switch vcType! {
        case .fileManager:
            savedImages = FileManag.shared.getImages(from: .ImageFolder)
        case .coreData:
            savedImages = CoreDataManager.shared.fethData().compactMap{ $0 }
        }
    }
    
    private func confCollectionView() {
        let layout = (self.collectionViewLayout as! UICollectionViewFlowLayout)
        layout.itemSize = CGSize(width: (self.view.bounds.width / 3) - 1,
                                 height: self.view.bounds.width / 2)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1 
        self.collectionView.register(ImageCollectionViewCell.self,
                                      forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
}


// MARK: - UICollectionViewDataSource
extension SaveImagesCollectionVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        savedImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier,
                                                      for: indexPath) as! ImageCollectionViewCell
        cell.setItem(withImage: savedImages[indexPath.row])
        return cell
    }
    
}
